Time::DATE_FORMATS[:datetime_jp] = '%Y年 %m月 %d日 %H時 %M分'

#日時表記をしたい時には、viewに下記のように表記する(xxxの部分は使用箇所によって変える必要あり)
#<%= xxx.created_at.to_s(:datetime_jp) %>
#<%= xxx.updated_at.to_s(:datetime_jp) %>