# 回帰分析結果を表で出力する

回帰分析ではよく下の画像のような表が報告されます。

![回帰分析の表](https://user-images.githubusercontent.com/44024242/80790660-64432c80-8bca-11ea-8645-ef4875db97cd.png)

このような表を出力するためには`outreg2`コマンドを使用します。

まず，`outreg2`を以下のコマンドをCommandウィンドウに入力してインストールします。

コマンド：
```
ssc install outreg2
```

次に回帰分析のコマンドに`outreg2`の行を以下のように加えます。

コマンド：
```
reg salary roe, r
outreg2 using regression.doc, replace
reg salary roe ros, r
outreg2 using regression.doc, append
```

上のコマンドで`reg salary roe, r`と`reg salary roe ros, r`は4.1で扱ったコマンドと全く同様のものです。2行目の`outreg2 using regression.doc, replace`では`regression.doc`というワードファイルがない場合には新規作成，ある場合には上書きした上で，1行目の回帰分析の結果をワードファイルに出力せよ，ということを指示しています。この時点で`regression.doc`には以下のように出力されています。

![回帰分析の表1つ目](https://user-images.githubusercontent.com/44024242/80791033-61950700-8bcb-11ea-8d0f-3734fd323114.png)

1つ目の回帰分析の結果が首都力されていることがわかります。コマンドの3行目は`regression.doc`に2つ目の回帰分析の結果を`append`，つまり追加せよということを命令しています。この4行のコマンドをまとめて実行すると，冒頭のような表が出力されます。

この例ではワードファイルに結果を出力していますが，`regression.doc`を`regression.xls`や`regression.txt`，`regression.tex`などと変えることによってエクセルファイル，テキストファイル，TeXファイルに結果を出力することもできます。

エクセルファイルの例：

![エクセルファイル](https://user-images.githubusercontent.com/44024242/80791381-6d34fd80-8bcc-11ea-963a-9b5b83dc3e92.png)

テキストファイルの例：

![テキストファイルの例](https://user-images.githubusercontent.com/44024242/80791473-b71de380-8bcc-11ea-8128-22e0aa0feb76.png)