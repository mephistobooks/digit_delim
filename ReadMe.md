# digit_delim ReadMe

## Description

provides the methods to separate a number with the delimiter for each 3 digits.
* 漢数字を含む文字列を実際の数値に変換する `KanNum.str_to_num` (`String#str_to_num`) を追加

## Installation

```
[sudo] gem install digit_delim
```

## Usage

```
# 漢数字 (String) を数値 (Fixnum) に変換
>> "百億".str_to_num
=> 10000000000

>> "12億3400万".str_to_num
=> 1234000000

# 数値を、漢数字に変換
>> "12億3400万".str_to_num.num_to_str
=> "12億3400万"

# 数字文字列に3桁区切りのカンマを入れる
>> "12億3400万".str_to_num.to_s.w_dm
=> "1,234,000,000"

# 4桁区切り
>> "12億3400万".str_to_num.to_s.w_dm(-1,4)
=> "12,3400,0000"

# 区切り付きの数字文字列を数値 (Float) に変換
>> "12億3400万".str_to_num.to_s.w_dm(-1,4).to_wof
=> 1234000000.0
```

See the test code in `test/` for more detail.

## Lisence

MIT Lisence.

## About the Author

YAMAMOTO, Masayuki


# End.
