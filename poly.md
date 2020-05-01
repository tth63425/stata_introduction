# 多項式を用いた回帰

ここでは多項式回帰とlogを用いた回帰分析の方法について紹介します。以下では`use http://www.stata-press.com/data/r13/regress`で得られるデータセットを用いていきます。Doファイルの最初の部分は以下のように変わります。

Doファイル：
```
clear all

capture log close

cd "/Users/akirasato/Docs/Okamuro_Seminar/stata_introduction"

log using stataoutput, replace

use http://www.stata-press.com/data/r13/regress
```

このデータセットには`y, x1, x2, x3`の4つの変数が含まれており，`x2`はバイナリ変数（0か1のみをとる変数）となっています。データの概要は以下のようになっています。

```
    Variable |        Obs        Mean    Std. Dev.       Min        Max
-------------+---------------------------------------------------------
           y |        148     21.2973    5.765791         12         41
          x1 |        148    3.014865    .4547325       2.19       3.89
          x2 |        148   -.2972973    .4586205         -1          0
          x3 |        148    3019.459    774.5455       1760       4840
```

ここでは以下の式で表される回帰分析を考えます。

$$
Y = \beta_0 + \beta_1 X_1 + \beta_2 X_1^2
$$