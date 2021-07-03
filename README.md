## 2021 小町研 新入生向けチュートリアル 前処理（単語分割）について
- 発表スライド
  - https://docs.google.com/presentation/d/1U6WVIdHlEYPvazCr72b125uDyYWVr5ucgtvY2s9i_Fw/edit#slide=id.p
 

## Build docker iamge
~~~
cd dockerfiles
docker build -t user_name/image_name .
~~~

## Run docker container

~~~
cd 作業したいディレクトリ
docker run -v `pwd`:/home --gpus all -it user_name/image_name
~~~

jupyter lab
~~~
docker run -it --rm --gpus all -v `pwd`:/home -p ホスト側のポート番号:コンテナ側のポート番号  jp-bart jupyter lab --port ホスト側のポート番号 --ip=0.0.0.0 --allow-root --no-browser
~~~


