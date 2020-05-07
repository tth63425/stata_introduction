* 保存されているデータなどを全て消去する
clear all

* logファイル（Stataのアウトプットが保存されているファイル）を閉じる
capture log close

* Working Directory（Doファイルやデータセットが入っているフォルダ）に移動する（人によって違います！）
cd "/Users/akirasato/Docs/stata_introduction/May7/do_files_etc"

/*
Stataの結果が全て保存されるlogファイルを作成する（stataoutput.smclというファイル名）
replaceはファイルがない場合は新規作成，ある場合は上書きすることを表します。
*/
log using stataoutput2, replace

* 使うデータセットをダウンロードする
* 途中から緑になってるけど，大丈夫。
import delimited AER_credit_card_data.csv



* データの概要を表示する（sumでも大丈夫）
summarize


* ヒストグラムを表示する
hist income
* 保存しましょう（pngで）
graph export hist2.png, replace


* 散布図を表示する
scatter expenditure income
* 保存しましょう
graph export scat2.png, replace

reg expenditure income, r

reg expenditure income age, r

gen income_quad = income^2

reg expenditure income income_quad age, r
