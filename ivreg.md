#### 操作変数法

以下では操作変数法を紹介します。操作変数法実際に分析する前に様々な仮定が満たされているかチェックする必要がありますが，ここではコマンドのみに注目して，それらは全て満たされているとします。

以下では`y`が被説明変数，`x`が操作変数でコントロールされている説明変数，`w1, w2`がコントロール変数，`z1, z2`が操作変数としています。

操作変数法には`ivregress 2sls`を使うと便利です。（2sls: two-stage least squares, 2段階最小2乗法）

Pseudo-code:
```
* 操作変数法
ivregress 2sls y (x = z1 z2) w1 w2, r
```
`ivregress`の最後にオプションで頑健性のある標準誤差を利用するために`,r`としていますが，固定効果がある場合は`, vce(cluster クラスターしたい変数)`とします。

過剰識別検定を行うには上の`ivregress`に続けて以下のようにします。

Pseudo-code:
```
* 過剰識別検定を行う，等分散（操作変数の数の方が内生変数より多い）
estat overid, forcenonrobust
* J-testのスコアとp値表示，不均一分散
dis "HR J-test = " r(score) " HR p-value = " r(p_score)
* 等分散の場合
dis "Homoskedastic J-test = " r(basmann) " Homoskedastic p-value = " r(p_basmann)
```

分散不均一と自己相関に対応した弱相間操作変数の検定は以下のようにします。まずコマンドウィンドウから`ssc install weakivtest`で`weakivtest`パッケージをStataに入れます。そして，以下のようにします。

コマンド：
```
ivregress 2sls y (x = z1 z2) w1 w2, r

* 弱相間操作変数の検定と誘導形（第一段階回帰）のF値，最悪のケースの閾値（10%での）表示
weakivtest
dis "First stage F = " r(F_eff)
dis "Critical value = " r(c_TSLS_10)
```

##### Anderson and Rubin (1949)の信頼区間（$$F$$がcritical valueより小さい時）

インストール：
```
ssc install weakiv
```

Pseudo-code:
```
ivregress 2sls y (x = z1 z2) w1 w2, r

* 信頼区間表示
weakiv
```
