#
# filename: digit_delim.rb
#
#

$NUM_DELIM_EACH = 3
$NUM_DELIM_CHAR = ','
$NUM_DELIM_ = '.'


class String

  # :method: w_dm
  # with delimiters: separate digit-string into each n-digits
  # with delimiters.
  # ==== Args
  # n :: the number of digits length of separated string.
  # ==== Return
  # separated string.
  def w_dm(n=3); self.gsub( /(\d+)?(\.\d*)?/ ) { \
    s1="#{$1}".dup; s2="#{$2}".dup; \
    s2="#{s2}00".slice(0,s2.size) if s2.size != 0
    s1.reverse.gsub( /\d{#{n}}(?=\d)/ ){|r| r+","}.reverse+s2 }; end
  alias to_f_old to_f
  
  # :method: wo_dm
  # without delimiters: remove the delimiters in digit-string.
  # ==== Args
  #
  # ==== Return
  # digit-string without the delimiters.
  def wo_dm; self.gsub(/,/, ""); end
  
  # :method: to_wof
  # remove delimiters in digit-string and convert it to Float.
  # ==== Args
  #
  # ==== Return
  # number in Float
  def to_wof; self.wo_dm.to_f_old; end
  
  # :method: to_fu
  # convert string to float concerning with unit.
  # ==== Args
  #
  # ==== Return
  # number in Float. if the original string has '%', the number is
  # divided by 100.
  def to_fu
    ret = self.to_wof
    if self =~ /%$/ then ret /= 100.0 else ret end
  end

end



#### endof filename: digit_delim.rb
