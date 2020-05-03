# 回帰分析の表に追加の値を記載する

4.4では回帰分析の結果を表にまとめる方法を紹介しましたが，仮説検定の結果などをこの表に加えたい場合もあるでしょう。この場合は以下のようにします。ここで使用しているデータセットは5.1と同様のデータセット[^*]です。まずはコメントなしのコマンドとその出力をみてみましょう。

コマンド：
```
reg admit gpa gre, r
test gpa
local F1 = r(F)
local P1 = r(p)
local effect1 = _b[_cons] + _b[gpa] * 3.5 + _b[gre] * 750
outreg2 using table1.doc, adds(F-value, `F1', p-value, `P1', Predicted Effect, `effect1') replace

probit admit gpa gre, r
local effect2 = normal(_b[_cons] + _b[gpa] * 3.5 + _b[gre] * 750)
outreg2 using table1.doc, adds(Predicted Effect, `effect2') append

logit admit gpa gre, r
local effect3 = logistic(_b[_cons] + _b[gpa] * 3.5 + _b[gre] * 750)
outreg2 using table1.doc, adds(Predicted Effect, `effect3') append
```

結果：
![outreg2の結果](https://user-images.githubusercontent.com/44024242/80917375-6dcebf00-8d99-11ea-9b29-fabe50be0cf3.png)

(1), (2), (3)にそれぞれ線形確率モデル，Probitモデル，Logitモデルの結果が表示され，その下に通常の`outreg2`では出力されない"F-value", "p-value", "Predicted Effect"の行が追加されていることがわかります。

次に同じコマンドをコメント付きでみてみましょう。

コマンド：
```
* 1つ目の回帰分析（線形確率モデル）
reg admit gpa gre, r
* gpa変数の回帰係数が0という帰無仮説の仮説検定
test gpa
* F1という変数を上の仮説検定のF値に設定
local F1 = r(F)
* P1という変数を上の仮説検定のp値に設定
local P1 = r(p)
* effect1という変数をGPAが3.5, GRE Scoreが750の学生が
* 大学院に受かる確率に設定
local effect1 = _b[_cons] + _b[gpa] * 3.5 + _b[gre] * 750
* outreg2のaddsの部分に(行の名前, 変数名, 行の名前,...)と書いて行を追加
* 初めてtable1.docを使うので最後はreplaceです。
outreg2 using table1.doc, adds(F-value, `F1', p-value, `P1', Predicted Effect, `effect1') replace

* 2つめの回帰分析（Probitモデル）
probit admit gpa gre, r
* effect2という変数をGPAが3.5, GRE Scoreが750の学生が
* 大学院に受かる確率に設定
local effect2 = normal(_b[_cons] + _b[gpa] * 3.5 + _b[gre] * 750)
* table1.docは2回目以降なので，最後はappendです。
outreg2 using table1.doc, adds(Predicted Effect, `effect2') append

* 3つめの回帰分析（Logitモデル）
logit admit gpa gre, r
* effect3という変数をGPAが3.5, GRE Scoreが750の学生が
* 大学院に受かる確率に設定
local effect3 = logistic(_b[_cons] + _b[gpa] * 3.5 + _b[gre] * 750)
outreg2 using table1.doc, adds(Predicted Effect, `effect3') append
```

追加する値は`local`を使うことで自分で定めることもできますし，F値やp値の場合は`r(F)`や`r(p)`，調整済み決定係数の場合は`e(r2_a)`を用います。`r()`や`e()`を用いて様々な値を出すことができます。

[^*] Wooldridge data sets by Jeffrey M. Wooldridge from http://fmwww.bc.edu/ec-p/data/wooldridge/ceosal1.des (accessed May 1, 2020).