# 残差を出力する

回帰分析の残差を出力するためには`predict`コマンドと`residuals`オプションを利用します。

コマンド：

```
reg salary roe, r
predict uhat1, residuals
reg salary roe ros, r
predict uhat2, residuals
```

上のコマンドでは1つ目の回帰分析の残差を`uhat1`に保存し，`uhat2`には2つ目の回帰分析の結果を保存しています。この4行をまとめて実行することで2つの回帰分析の残差がデータに保存され，データを見ると元からある変数に加えて`uhat1`と`uhat2`が追加されていることがわかります。