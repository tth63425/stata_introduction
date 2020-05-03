# 複数の係数を含む仮説検定

ここでは，複数の係数を含む仮説検定をどのようにStataで行うかを紹介します。ここでは

```
use http://fmwww.bc.edu/ec-p/data/wooldridge/gpa1 
```

でダウンロードできるデータセット[^*]使います。大学生のGPAの決定要因を調べるためのデータセットでGPAの他にも性別や学年に関する情報があります。

ここでは以下のような回帰式を考えます。$$\text{sophomore}, \text{junior}, \text{senior}$$の各変数はそれぞれ該当の学年であれば1を，そうでなければ0のダミー変数です。

$$
\text{GPA}_i = \beta_0 + \beta_1 \text{sophomore}_i + \beta_2 \text{junior}_i + \beta_3 \text{senior}_i + u_i
$$

この回帰式は以下のコマンドで分析することができます。

コマンド：
```
reg colGPA soph junior senior, r
```

結果：
```
. reg colGPA soph junior senior, r

Linear regression                               Number of obs     =        141
                                                F(3, 137)         =       0.60
                                                Prob > F          =     0.6140
                                                R-squared         =     0.0162
                                                Root MSE          =     .37331

------------------------------------------------------------------------------
             |               Robust
      colGPA |      Coef.   Std. Err.      t    P>|t|     [95% Conf. Interval]
-------------+----------------------------------------------------------------
        soph |   .2051282   .3420477     0.60   0.550    -.4712476    .8815039
      junior |    .032906   .1132715     0.29   0.772    -.1910805    .2568925
      senior |  -.0432286   .1154276    -0.37   0.709    -.2714787    .1850215
       _cons |   3.061538   .1050116    29.15   0.000     2.853885    3.269192
------------------------------------------------------------------------------
```

ここで帰無仮説が$$H_0: \beta_1 = \beta_2 = \beta_3 = 0$$であるような仮説検定を行うことを考えます。このように複数の係数を含む仮説検定の場合は通常$$F$$検定を用います。この検定は以下のコマンドで行うことができます。

コマンド：
```
test soph junior senior
```

結果：
```
. test soph junior senior

 ( 1)  soph = 0
 ( 2)  junior = 0
 ( 3)  senior = 0

       F(  3,   137) =    0.60
            Prob > F =    0.6140
```

$$p$$値が0.05より大きいため，有意水準5%で帰無仮説を棄却することはできません。

次に$$H_0 : \beta_1 = 0.5 \text{ and } \beta_3 = \beta_4$$という帰無仮説を考えてみましょう。これは以下のコマンドで実行できます。

コマンド：
```
test (soph = 0.5) (junior = senior)
```

結果：
```
. test (soph = 0.5) (junior = senior)

 ( 1)  soph = .5
 ( 2)  junior - senior = 0

       F(  2,   137) =    1.08
            Prob > F =    0.3429
```

この場合も帰無仮説を有意水準5%で棄却できません。


[^*] Wooldridge data sets by Jeffrey M. Wooldridge from http://fmwww.bc.edu/ec-p/data/wooldridge/gpa1.des (accessed May 1, 2020).