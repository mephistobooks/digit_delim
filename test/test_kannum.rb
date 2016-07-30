#
# filename: test_kannum.rb
# To do this test case,
# ```
# rake test
# rake test TESTOPTS="--testcase=/KanNum/"
# rake test TESTOPTS="--name=/basic/"
# rake test TESTOPTS="--help"
#
# ```
#
#
require "helper"
require 'test/unit'

# Testee.
require "digit_delim"


class TestKanNum < Test::Unit::TestCase

  def setup

    @pattern_t1 = "12億3456万"
    @pattern_n1 = 12_3456_0000

    @pattern_t2 = "100億"
    @pattern_n2 = 100_0000_0000
    @pattern_t21 = "百億"
    @pattern_t22 = "１００億"

    @pattern_t3 = "2千億3千4百十万"
    @pattern_n3 = 2000_3410_0000
    @pattern_t31 = "2千億3千十万"
    @pattern_n31 = 2000_3010_0000
    @pattern_t32 = "2千億千十万"
    @pattern_n32 = 2000_1010_0000

    @pattern_t4 = "千百3十万"
    @pattern_n4 = 1030_0000
    @pattern_t5 = "参拾"
    @pattern_n5 = 30
    @pattern_t6 = "参"
    @pattern_n6 = 3
    @pattern_t7 = "拾"
    @pattern_n7 = 10

  end

  def tear
  end

  def test_basic

    ret = "壱萬参千弐百".str_to_num
    exp = 1_3200
    assert_equal( exp, ret )

    ret = @pattern_t1.str_to_num
    exp = @pattern_n1
    assert_equal( exp, ret )

    ret = KanNum.str_to_num @pattern_t2
    exp = @pattern_n2
    assert_equal( exp, ret )

    ret = KanNum.str_to_num @pattern_t21
    exp = @pattern_n2
    assert_equal( exp, ret )

    ret = KanNum.str_to_num @pattern_t22
    exp = @pattern_n2
    assert_equal( exp, ret )

    ret = KanNum.str_to_num @pattern_t3
    exp = @pattern_n3
    assert_equal( exp, ret )

    ret = KanNum.str_to_num @pattern_t31
    exp = @pattern_n31
    assert_equal( exp, ret )

    ret = KanNum.str_to_num @pattern_t32
    exp = @pattern_n32
    assert_equal( exp, ret )

    ret = KanNum.str_to_num @pattern_t4
    exp = 1130_0000
    assert_equal( exp, ret )

    ret = KanNum.str_to_num @pattern_t5
    exp = 30
    assert_equal( exp, ret )

    ret = KanNum.str_to_num @pattern_t6
    exp = 3
    assert_equal( exp, ret )

    ret = KanNum.str_to_num @pattern_t7
    exp = 10
    assert_equal( exp, ret )

  end

  def test_str_to_num

    ret = "0.7億".str_to_num
    exp = 7000_0000
    assert_equal( exp, ret )

    ret = "-5.2億".str_to_num
    exp = -5_2000_0000
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

  def test_num_to_str

    #
    ret = 1_3200.num_to_str
    exp = "1万3200"
    assert_equal( exp, ret )

    ret = @pattern_n1.num_to_str
    exp = @pattern_t1
    assert_equal( exp, ret )

    ret = KanNum.num_to_str @pattern_n2
    exp = @pattern_t2
    assert_equal( exp, ret )

    ret = KanNum.num_to_str @pattern_n3
    exp = "2000億3410万"
    assert_equal( exp, ret )

    ret = @pattern_n31.num_to_str
    exp = "2000億3010万"
    assert_equal( exp, ret )

    ret = @pattern_n32.num_to_str
    exp = "2000億1010万"
    assert_equal( exp, ret )

    ret = @pattern_n4.num_to_str
    exp = "1030万"
    assert_equal( exp, ret )

    ret = @pattern_n5.num_to_str
    exp = "30"
    assert_equal( exp, ret )

    ret = @pattern_n6.num_to_str
    exp = "3"
    assert_equal( exp, ret )

    ret = @pattern_n7.num_to_str
    exp = "10"
    assert_equal( exp, ret )

  end

end


#### endof filename: test_kannum.rb
