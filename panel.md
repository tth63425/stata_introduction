#### パネルデータの分析

以下ではパネルデータの分析を行います。パネルデータの分析は同一のものを`reg`, `xtreg`, `areg`など様々な方法で分析することができますが，ここではパッケージの`reghdfe`[^*]を利用します。

コマンドウィンドウでインストール：
```
ssc install reghdfe
```

以下ではPseudo Codeのみ示します。

コマンド：
```
* どの県かを表すprefと年を表すyearをパネルデータとしてStataに認識させる
xtset pref year

* 概要を表示
xtdescribe

/* 
yをx1とx2に回帰させる
Year Fixed EffectとPrefecture Fixed Effect，
さらにどの地方かを示すregionとyearをかけた固定効果を入れる。
vce()はかっこ内の変数でクラスター化された頑健な標準誤差を示す。
この場合は都道府県レベルでのクラスター化
*/

reghdfe y x1 x2, absorb(pref year region#year), vce(cluster pref)
```

#### 固定効果がある場合の残差プロット

基本的な形は`reghdfe 変数, absorb(固定効果) residual(残差につける変数名)`で残差を出力して，`binscatter`でビン化された散布図にします。

Pseudo-code：
```
reghdfe y, absorb(company_id) residuals(y_residual)
reghdfe x, absorb(company_id) residuals(x_residual)
binscatter y_residual x_residual
```

[^*] http://scorreia.com/software/reghdfe/