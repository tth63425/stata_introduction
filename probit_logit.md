# Probit, Logitモデル

## Probitモデル

Probitモデルとは以下のようなモデルのことです。被説明変数がダミー変数の場合，線形確率モデルを用いると予測値が$$[0,1]$$の範囲に収まりません。これを回避する方法の一つにProbitモデルがあります。

$$
    \begin{aligned} 
    \text{E}[Y_i | X_i, W_i] &= P(Y_i = 1 | X_i, W_i) \\\\ 
    &= \Phi (\beta_0 + \beta_1 X_i + \beta_2 W_i)
    \end{aligned}
$$

ただし，$$\Phi()$$は正規分布関数です。

$$
\Phi(z) = (2\pi)^{\frac{1}{2}} \int_{-\infty}^{z} \exp \left(-\frac{x^2}{2}\right) dx
$$

このProbitモデルの分析をStataで行うためには以下のようにします。ここでは`use https://stats.idre.ucla.edu/stat/stata/dae/logit.dta`でダウンロードできるデータセット[^*]を用います。このデータは大学院を志望する大学生のGPA（`gpa`）， GREスコア（`gre`），トップスクールであるかどうか（`topnotch`変数），大学院への入学が許可されたどうかに関する変数（`admit`）が含まれています。

#### データの概要

コマンド：
```
sum
```

結果：
```
. sum

    Variable |        Obs        Mean    Std. Dev.       Min        Max
-------------+---------------------------------------------------------
       admit |        400       .3175    .4660867          0          1
         gre |        400       587.7    115.5165        220        800
    topnotch |        400       .1625    .3693709          0          1
         gpa |        400      3.3899    .3805668       2.26          4
```

#### StataでのProbit分析

以下の回帰式を考えます。

$$
\text{Admit}_i = \Phi (\beta_0 + \beta_1 \text{GPA}_i + \beta_2 \text{GRE Score}_i)
$$

これを分析するには以下のようにします。

コマンド：
```
probit admit gpa gre, r
```

結果：
```
. probit admit gpa gre, r

Iteration 0:   log pseudolikelihood = -249.98826  
Iteration 1:   log pseudolikelihood = -240.12653  
Iteration 2:   log pseudolikelihood =   -240.094  
Iteration 3:   log pseudolikelihood =   -240.094  

Probit regression                               Number of obs     =        400
                                                Wald chi2(2)      =      19.41
                                                Prob > chi2       =     0.0001
Log pseudolikelihood =   -240.094               Pseudo R2         =     0.0396

------------------------------------------------------------------------------
             |               Robust
       admit |      Coef.   Std. Err.      z    P>|z|     [95% Conf. Interval]
-------------+----------------------------------------------------------------
         gpa |    .454575   .1966267     2.31   0.021     .0691936    .8399563
         gre |   .0016425   .0006396     2.57   0.010      .000389     .002896
       _cons |  -3.003536     .63602    -4.72   0.000    -4.250113    -1.75696
------------------------------------------------------------------------------
```

#### 確率を計算する

ここでGPAが3.5，GREスコアが750である人が大学院に入学を許可される確率を求めます。これは以下のようにしてできます。

コマンド：
```
* disはdisplayの略。displayとしても良い。
dis normal(_b[_cons] + _b[gpa] * 3.5 + _b[gre] * 750)
```

結果；
```
. dis normal(_b[_cons] + _b[gpa] * 3.5 + _b[gre] * 750)
.42833245
```

よって，GPAが3.5，GREスコアが750である人が大学院に入学を許可される確率は約42.8%であることがわかります。ここで`_b[_cons]`, `_b[gpa]`, `_b[gre]`はそれぞれ$$\beta_0, \beta_1, \beta_2$$を表しており，`normal`は正規分布関数を表します。

## Logitモデル

次にLogitモデルでも全く同じ分析をやってみましょう。

$$
\text{Admit}_i = F (\beta_0 + \beta_1 \text{GPA}_i + \beta_2 \text{GRE Score}_i)
$$

ただし，$$F()$$はロジスティック分布関数です。

$$
F(z) = \frac{1}{1 + \exp(-z)}
$$

コマンド：
```
logit admit gpa gre, r
```

結果：
```
. logit admit gpa gre, r

Iteration 0:   log pseudolikelihood = -249.98826  
Iteration 1:   log pseudolikelihood =  -240.2678  
Iteration 2:   log pseudolikelihood = -240.17203  
Iteration 3:   log pseudolikelihood = -240.17199  
Iteration 4:   log pseudolikelihood = -240.17199  

Logistic regression                             Number of obs     =        400
                                                Wald chi2(2)      =      18.95
                                                Prob > chi2       =     0.0001
Log pseudolikelihood = -240.17199               Pseudo R2         =     0.0393

------------------------------------------------------------------------------
             |               Robust
       admit |      Coef.   Std. Err.      z    P>|z|     [95% Conf. Interval]
-------------+----------------------------------------------------------------
         gpa |   .7546869    .334156     2.26   0.024     .0997532    1.409621
         gre |   .0026907   .0010717     2.51   0.012     .0005902    .0047912
       _cons |  -4.949378   1.075326    -4.60   0.000    -7.056979   -2.841778
------------------------------------------------------------------------------
```

次に先ほどと同様にGPAが3.5，GREスコアが750である人が大学院に入学を許可される確率を求めましょう。

コマンド：
```
dis logistic(_b[_cons] + _b[gpa] * 3.5 + _b[gre] * 750)
```

結果：
```
. dis logistic(_b[_cons] + _b[gpa] * 3.5 + _b[gre] * 750)
.42801332
```

よって，Logit分析では確率は約42.8%と算出されました。（Probitの場合とさほど結果は変わりありません。）

### 計算された確率の差を求める

先ほどはGPAが3.5，GREスコアが750である人が大学院に入学を許可される確率を求めましたが，
- GPAが3.5，GREスコアが750である人
- GPAが4，GREスコアが790である人
が大学院に入学を許可される確率の差を求めたいとします。これは以下のようにします。

コマンド：
```
nlcom logistic(_b[_cons] + _b[gpa] * 4 + _b[gre] * 790) - logistic(_b[_cons] + _b[gpa] * 3.5 + _b[gre] * 750)
```

結果：
```
. nlcom logistic(_b[_cons] + _b[gpa] * 4 + _b[gre] * 790) - logistic(_b[_cons] + _b[gpa] * 3.5 + _b[gre] * 750)

       _nl_1:  logistic(_b[_cons] + _b[gpa] * 4 + _b[gre] * 790) - logistic(_b[_cons] + _b[gpa] * 3.5 + _b[gre] * 750)

------------------------------------------------------------------------------
       admit |      Coef.   Std. Err.      z    P>|z|     [95% Conf. Interval]
-------------+----------------------------------------------------------------
       _nl_1 |   .1205851   .0383848     3.14   0.002     .0453523    .1958179
------------------------------------------------------------------------------
```

よって，確率の差は約12.1%であることがわかりました。`nlcom`はNon-Linear Combinationの略です（コマンドは`nlcom`としてください）。上の例はLogit回帰の例ですが，Probit回帰の場合も同様で，Probit分析を行なった後に

コマンド：
```
nlcom normal(_b[_cons] + _b[gpa] * 4 + _b[gre] * 790) - normal(_b[_cons] + _b[gpa] * 3.5 + _b[gre] * 750)
```

とすればProbit回帰の場合の確率の差を求めることができます。

[^*] PROBIT REGRESSION | STATA ANNOTATED OUTPUT. UCLA: Statistical Consulting Group. from https://stats.idre.ucla.edu/stata/output/probit-regression/ (accessed May 3, 2020).