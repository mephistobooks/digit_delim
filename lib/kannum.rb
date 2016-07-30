#
#
#
#


module KanNum
  N_数 = {
    '〇'=>0,
    '一'=>1, '壱'=>1,
    '二'=>2, '弐'=>2,
    '三'=>3, '参'=>3,
    '四'=>4,
    '五'=>5,
    '六'=>6,
    '七'=>7,
    '八'=>8,
    '九'=>9,

    '０'=>0,
    '１'=>1,
    '２'=>2,
    '３'=>3,
    '４'=>4,
    '５'=>5,
    '６'=>6,
    '７'=>7,
    '８'=>8,
    '９'=>9,
  }

  N_数_ext = {
    '零'=>0,
    '肆'=>4,
    '伍'=>5,
    '陸'=>6,
    '漆'=>7, '質'=>7,
    '捌'=>8,
    '玖'=>9,
  }

  N_倍数 = {
    '十' => 10**1, '拾' => 10**1,
    '百' => 10**2,
    '千' => 10**3,
  }

  N_倍数_ext = {
    '阡' => 10**3,
  }

  N_合成倍数 = {
    '廿' => 2*10,
    '丗' => 3*10,
    '卌' => 4*10,
  }

  N_単位数 = {
    '万' => 10**4, '萬' => 10**4,
    '億' => 10**8,
    '兆' => 10**12,
    '京' => 10**16,
    '垓' => 10**20,
  }

  N_ary = [ N_数, N_倍数, N_単位数, ]
  N_ary_loose = N_ary + [ N_数_ext, N_倍数_ext, N_合成倍数, ]

  N_keys = N_ary.map{|e| e.keys}.inject(:+)
  N_keys_loose = N_ary_loose.map{|e| e.keys}.inject(:+)

  #
  #
  #
  def self.numable?( str, dict = N_keys )
    tmp_str = str.gsub(/[0-9０-９]/,'')
    # tmp = dict.map{|e| e.keys}.inject(:+)
    tmp = dict
    #tmp += (0..9).to_a

    ret = true
    (0..(tmp_str.size-1)).each {|i|
      c = tmp_str[i]
      if tmp.include?(c)
        next
      else
        ret = false
        break
      end
    }
    ret
  end
  def self.numable_loose?( str )
    numable?(str, N_keys_loose)
  end


  # simple chr-to-chr translation: 0-9.
  #
  #
  def self.translate_phase0( str )
    #str = str.tr("０-９", "0-9")

    tmp_str = str
    # str.split(//).each_with_index{|e,i|
    (0..(str.length-1)).each{|i|
      c = str[i]
      tmp = N_数[c]
      tmp_str[i] = tmp.to_s unless tmp.nil?
    }

    tmp_str
  end

  RE_NUM_O = "-.0-9"
  RE_NUM = "[#{RE_NUM_O}]+"
  RE_NONNUM = "[^#{RE_NUM_O} ]"

  # create parse tree for str:
  #   [ [[ num, Num, ... ], UnitNum], ... ]
  #
  def self.translate_phase1( str )
    ret = []
    tmp_ary = []
    units = N_単位数.keys

    # $stderr.puts "#{__method__} str: #{str}"
    # str.split(//).each do |c|
    (0..(str.length-1)).each do |i|
      c = str[i]

      if units.include?(c)
        tmp = tmp_ary.join
        # $stderr.puts "#{__method__} tmp: #{tmp}"
        #tmp = tmp.gsub(/([0-9]+)([^ 0-9])/, '\1 \2')
        tmp = tmp.gsub(/(#{RE_NUM})(#{RE_NONNUM})/, '\1 \2')
        # $stderr.puts "#{__method__} tmp: #{tmp}"
        #tmp = tmp.gsub(/([^ 0-9])([0-9]+)/, '\1 \2')
        tmp = tmp.gsub(/(#{RE_NONNUM})(#{RE_NUM})/, '\1 \2')

        #tmp = tmp.gsub(/([^ 0-9])([^ 0-9])/, '\1 \2')
        tmp = tmp.gsub(/(#{RE_NONNUM})(#{RE_NONNUM})/, '\1 \2')
        # $stderr.puts "#{__method__} tmp: #{tmp}"
        tmp = tmp.split(/\s+/)
        # $stderr.puts "#{__method__} tmp: #{tmp}"
        ret << [tmp, c]
        tmp_ary = []
        next
      end
      tmp_ary << c
      # $stderr.puts "#{__method__} tmp_ary: #{tmp_ary}"
    end
    ret << tmp_ary if tmp_ary.size > 0

    ret
  end

  # calculate number due to parse tree.
  # ==== Args
  # ary :: parse tree with _phase1
  # ==== Return
  # number
  def self.translate_phase2( ary )
    ret = 0
    # $stderr.puts "{#{__method__}} ary: #{ary}"

    #
    ary.each do |ua|
      na, u = ua
      if na.class != Array
        na = ua
        u = '1'
      end

      tmp = 0
      tmp_ary = []

      na.each do |e|
        tmp_ary << e
        if e =~ /[0-9]+/
        else
          # $stderr.puts "#{__method__} tmp_ary: #{tmp_ary}"
          a = 1
          b = N_倍数[tmp_ary[-1]]
          #a = tmp_ary[0].to_i if tmp_ary.size > 1
          a = tmp_ary[0].to_f if tmp_ary.size > 1

          tmp += a*b
          tmp_ary = []
        end
      end
      # $stderr.puts "#{__method__} tmp_ary: #{tmp_ary}"
      #tmp += tmp_ary[0].to_i if tmp_ary.size != 0
      tmp += tmp_ary[0].to_f if tmp_ary.size != 0

      tmp_u = N_単位数[u]
      if tmp_u.nil?
        ret += tmp * 1
      else
        ret += tmp * tmp_u
      end

    end

    if ret - ret.to_i > 0.0
    else
      ret = ret.to_i
    end

    ret
  end

  def self.str_to_num( str )

    tmp = translate_phase0(str)
    # $stderr.puts "result0: #{tmp}"
    tmp = translate_phase1(tmp)
    # $stderr.puts "result1: #{tmp}"
    ret = translate_phase2(tmp)

    ret
  end


  #
  #
  #
  def self.convert_helper( num )

    tmp = nil
    N_単位数.each_pair do |k,v|
      # $stderr.puts "#{__method__} #{k} #{v}"
      if num >= v
        tmp ||= k
        tmp = k if not(tmp.nil?) and v > N_単位数[tmp]
        # $stderr.puts "#{__method__} tmp: #{tmp}"
        next
      else
        break
      end
    end

    tmp
  end

  def self.convert_phase0( num )
    ret = []

    tmp_num = num
    while tmp = convert_helper(tmp_num)

    u = N_単位数[tmp]
    r = tmp_num/u
    ret << [r.to_i, tmp]
    tmp_num -= r*u
    end

    ret << tmp_num if tmp_num != 0
    ret
  end

  def self.convert_phase1( ary )
    ary.flatten.join
  end

  def self.num_to_str( num )

    tmp = convert_phase0(num)
    # $stderr.puts "{#{__method__}}result0: #{tmp}"
    ret = convert_phase1(tmp)
    # $stderr.puts "result1: #{ret}"

    ret
  end

end


#
#
#
class String
  def str_to_num; KanNum.str_to_num self; end
end

class Fixnum
  def num_to_str; KanNum.num_to_str self; end
end


#### endof filename: .rb
