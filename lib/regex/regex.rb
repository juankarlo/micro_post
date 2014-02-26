def regexp_match(regexp)
  addresses =%w[user@foo.com user.@foo.com user-@foo.com a_us-er@f.b.org frst.lst@foo.jp a+b@baz.cn user@foo,com user_at_foo.org example.user@foo. foo@bar_baz.com foo@bar.com foo@bar+baz.com foo@bar..com]
  addresses.each do |address|
    if regexp.match address
      p "#{regexp.match address} "
    end
  end
end

