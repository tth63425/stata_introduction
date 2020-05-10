### ビン化された散布図(Binned Scatterplot)

7章以降はパネルデータを扱いますが，ここで今後頻繁に使用する，ビン化された散布図について紹介します。

ビン化された散布図とは，$$x$$軸方向に，それぞれの分割に含まれるデータの個数が等しくなるようにデータを$$k$$分割し，1つの分割内に含まれるデータの平均値でその分割を代表させるという手法です。英語だとBinned Scatterplotなどと言われます。

`binscatter`をダウンロードする必要があるので，コマンドウィンドウから入れましょう。

コマンド：
```
ssc install binscatter
```

ビン化された散布図の威力はデータの個数が多い時に発揮されます。以下の例をみていただければ，それは一目瞭然だと思います。データは`use http://fmwww.bc.edu/ec-p/data/wooldridge/401ksubs`を使っています[^*]。

コマンド
```
scatter inc age
graph export bin1.png, replace

binscatter inc age
graph export bin2.png, replace
```

普通の散布図；
![普通の散布図](https://user-images.githubusercontent.com/44024242/81497415-62c7e180-92f9-11ea-9a59-d59f51445776.png)

ビン化された散布図：
![ビン化された散布図](https://user-images.githubusercontent.com/44024242/81497457-90148f80-92f9-11ea-8a9c-332f19c33dcb.png)

[^*] Wooldridge data sets by Jeffrey M. Wooldridge from http://fmwww.bc.edu/ec-p/data/wooldridge/datasets.list.html (accessed May 10, 2020).
