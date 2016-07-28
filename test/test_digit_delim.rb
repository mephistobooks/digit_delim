#!/usr/local/bin/ruby -w

# filename: test_digit_delim.rb
# To do this test case, ``rake test``.
#
#require "rubygems"
#gem "test-unit"
#require "test/unit"
require "helper"
require 'test/unit'

# Testee.
require "digit_delim"


class TestDigitDelim < Test::Unit::TestCase

  def test_w_dm_1
    assert_equal( "123", "123".w_dm )
    assert_equal( "1,000", 1000.to_s.w_dm )

    assert_equal( "23,456,789", "23456789".w_dm )
    assert_equal( "23,456,789.0123", "23456789.0123".w_dm )
    assert_equal( "23,456,789.0123", "23456789.0123".w_dm(-1, 3) )
    assert_equal( "2345,6789.0123", "23456789.0123".w_dm(-1, 4) )
    
    assert_equal( "23,456,789.01", "23456789.0123".w_dm(2) )
    assert_equal( "2345,6789.01", "23456789.0123".w_dm(2,4) )
  end

  def test_w_dm_2
    assert_equal( "0.0123", "0.0123".w_dm )
    assert_equal( ".0123", ".0123".w_dm )
    assert_equal( "0.0", "0.0".w_dm )
    assert_equal( "0", "0".w_dm )
    #assert_equal( "1,234.0", "1234.".w_dm )
    assert_equal( "1,234.", "1234.".w_dm )
    assert_equal( "1,234.01234", "1234.01234".w_dm )
    assert_equal( "12,345,678.01234", "12345678.01234".w_dm )
  end

  def test_w_dm_3
    t_pat = 23456789.0123

    assert_equal( "2345,6789.01", t_pat.to_s.w_dm(2, 4) )
    assert_equal( "2,3,4,5,6,7,8,9.01", t_pat.to_s.w_dm(2, 1) )

    # with sign.
    assert_equal( "+2,100", sprintf("%+d", 2_100).w_dm )
    assert_equal( "-2,100", sprintf("%+d", -2_100).w_dm )
    
    # with sign, in percentage (符号付き, パーセント表記)
    assert_equal( "-10.10%", sprintf("%+.2f%", -0.1010*100).w_dm )
    assert_equal( "+10.10%", sprintf("%+.2f%", +0.1010*100).w_dm )

  end

  def test_wo_dm
    assert_equal( "100000", "100,000".wo_dm )
    assert_equal( "100000", "100,000".wo_dm.to_i.to_s )
    assert_equal( "100000.0123", "100,000.0123".wo_dm )
  end

  def test_to_wof
    exp = 100_000

    assert_not_equal( exp, "100,000".to_f )
    assert_equal( 100.0, "100,000".to_f )

    assert_equal( exp, "100,000".to_wof )
    assert_not_equal( exp.to_s, "100,000".to_wof.to_s )
    assert_equal( exp.to_s + ".0", "100,000".to_wof.to_s )

    #
    assert_equal( 1791.11, "1,791.11".to_wof )
  end

  def test_to_wof_stocks
    assert_equal( 1, "1株".to_wof )
    assert_equal( 1.05, "1.05株".to_wof )

    assert_equal( 10, "10百万円".to_wof )
  end

  def test_to_fu
    assert_equal( 0.05, "5%".to_fu )
    assert_equal( 1.05, "105%".to_fu )
    assert_equal( 0.051, "5.1%".to_fu )
    assert_equal( -0.051, "-5.1%".to_fu )

    assert_equal( 5, "5".to_fu )
  end

end


#### endof filename: test_digit_delim.rb
