#
# filename: digit_delim.rb
#
#

$NUM_DELIM_EACH = 3
$NUM_DELIM_CHAR = ','
$NUM_DELIM_ = '.'


#
# w_dm: with delimiter
# wo_dm: without delimiter
# to_f: updated original to_f, which can deal with delimiter.
#
class String
  def w_dm(n=3); self.gsub( /(\d+)?(\.\d*)?/ ) { \
    s1="#{$1}".dup; s2="#{$2}".dup; \
    s2="#{s2}00".slice(0,s2.size) if s2.size != 0
    s1.reverse.gsub( /\d{#{n}}(?=\d)/ ){|r| r+","}.reverse+s2 }; end
  alias to_f_old to_f
  def wo_dm; self.gsub(/,/, ""); end
  def to_wof; self.wo_dm.to_f_old; end
  def to_fu
    ret = self.to_wof
    if self =~ /%$/ then ret /= 100.0 else ret end
  end
end



#### endof filename: digit_delim.rb
