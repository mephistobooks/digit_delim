#
# filename: test_kannum.rb
# To do this test case, ``rake test``.
#
require "helper"
require 'test/unit'

# Testee.
require "digit_delim"


class TestKanNum < Test::Unit::TestCase

  def setup

    @pattern_t1 = "12億3456万"
    @pattern_t2 = "100億"
    @pattern_t21 = "百億"
    @pattern_t22 = "１００億"

    @pattern_t3 = "2千億3千4百十万"
    @pattern_t31 = "2千億3千十万"
    @pattern_t32 = "2千億千十万"

    @pattern_t4 = "千百3十万"
    @pattern_t5 = "参拾"
    @pattern_t51 = "参"
    @pattern_t52 = "拾"

  end

  def tear
  end

  def test_basic

    ret = "壱萬参千弐百".str_to_num
    exp = 1_3200
    assert_equal( exp, ret )

    ret = @pattern_t1.str_to_num
    exp = 12_3456_0000
    assert_equal( exp, ret )

    ret = KanNum.str_to_num @pattern_t2
    exp = 100_0000_0000
    assert_equal( exp, ret )

    ret = KanNum.str_to_num @pattern_t21
    exp = 100_0000_0000
    assert_equal( exp, ret )

    ret = KanNum.str_to_num @pattern_t22
    exp = 100_0000_0000
    assert_equal( exp, ret )

    ret = KanNum.str_to_num @pattern_t3
    exp = 2000_3410_0000
    assert_equal( exp, ret )

    ret = KanNum.str_to_num @pattern_t31
    exp = 2000_3010_0000
    assert_equal( exp, ret )

    ret = KanNum.str_to_num @pattern_t32
    exp = 2000_1010_0000
    assert_equal( exp, ret )

    ret = KanNum.str_to_num @pattern_t4
    exp = 1130_0000
    assert_equal( exp, ret )

    ret = KanNum.str_to_num @pattern_t5
    exp = 30
    assert_equal( exp, ret )

    ret = KanNum.str_to_num @pattern_t51
    exp = 3
    assert_equal( exp, ret )

    ret = KanNum.str_to_num @pattern_t52
    exp = 10
    assert_equal( exp, ret )

  end

  def test_numable?

    ret = KanNum.numable? @pattern_t1
    exp = true
    assert_equal( exp, ret )

    ret = KanNum.numable? "数字ではない文字をふくむ1つの例"
    exp = false
    assert_equal( exp, ret )

  end

end


#### endof filename: test_kannum.rb