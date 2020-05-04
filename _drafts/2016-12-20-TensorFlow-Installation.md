
* [TensorFlow 설치]()
* TensorFlow 기본 사용법

TensorFlow 메인 화면에서 [Get Started](https://www.tensorflow.org/get_started/) 버튼을 누르면 TensorFlow에 대한 기본 내용을 간단한 소스를 곁들여 설명합니다. [^get_started]

### Introduction

해당 소스에서는 이차원 데이터를 직선으로 피팅하는 예제를 다루고 있습니다. 

그리고 각 코드가 의미하는 바를 설명하면서 TensorFlow의 작동 방식을 설명하고 있습니다. 

TensorFlow는 먼저 data flow graph를 만들고, 실제 연산은 session이 만들어져서 run 함수가 호출될 때에서야 시작합니다.

### Download and Setup

TensorFlow는 다양한 방법으로 설치할 수 있는데, [Anaconda installation](https://www.tensorflow.org/get_started/os_setup#anaconda_installation)도 지원하고 있습니다. [^anaconda_installation]

#### Anaconda로 설치하기

```
$ conda create -n tensorflow python=3.5
```

실제 Anaconda로 TensorFlow를 설치할 때는 먼저 conda로 위와 같이 가상환경을 만든 다음에 아래와 같이 conda-forge 옵션(?)을 사용합니다. [^conda-forge]

```
$ source activate tensorflow

(tensorflow)$ conda install -c conda-forge tensorflow
```

> conda-forge에 대해서는 다음에 따로 정리가 필요할 것 같습니다. 

TensorFlow를 IPython에서 사용하기 위해 IPython을 설치합니다. (필요없을 수도 있을 것 같습니다.)

```
(tensorflow)$ conda install ipython
```

#### 소스로 설치하기

설명을 보다보니까 Anaconda로 설치하면 TensorFlow의 CPU 버전만 사용할 수 있는 것 같습니다. 맥에서 GPU 버전을 사용하려면 반드시 Installing from sources 과정을 따라서 소스를 이용해서 설치해야할  것 같습니다. 

### TensorFlow 설치 완료후 테스트하기 

#### 터미널에서 테스트하기

아래와 같이 터미널에서 파이썬 쉘을 실행해서 간단하게 테스트해볼 수 있습니다. [^test_the_tensorflow_installation]

```
(tensorflow) ...$ python
...
>>> import tensorflow as tf
>>> hello = tf.constant('Hello, TensorFlow!')
>>> sess = tf.Session()
>>> print(sess.run(hello))
b'Hello, TensorFlow!'
>>> a = tf.constant(10)
>>> b = tf.constant(32)
>>> print(sess.run(a + b))
42
>>> 
```

큰 무리없이 동작하는 것을 볼 수 있습니다.

### 참고 자료

[애플기기를 위한 딥러닝 프레임워크](https://tensorflow.blog/2016/01/02/애플기기를-위한-딥러닝-프레임워크/)

[텐서플로우 소스 구조 분석 (TensorFlow Internal)](http://team.airpage.org/meta/go/927)

#### tensorflow

[GPU computing with tensorflow on Mac OS 10.12](http://vinhqdang.github.io/2016/09/28/gpu-computing-with-tensorflow-on-mac-os-1012)

[tensorflow/tensorflow](https://github.com/tensorflow/tensorflow) : 

[Download and Setup](https://github.com/tensorflow/tensorflow/blob/master/tensorflow/g3doc/get_started/os_setup.md)

[Download and Setup](https://www.tensorflow.org/versions/r0.10/get_started/os_setup#using-pip) : Getting Started r0.10

### TensorFlow 설치 

[ML lab 01 - TensorFlow의 설치및 기본적인 operations](https://www.youtube.com/watch?v=cbPjsOivFOs)

### 기타 연결

딥 러닝에 대한 내용은 [Deep Learning](../_draft/2016-10-30-Deep-Learning.md) 글을 참고하시기 바랍니다. (나중에 포스트로 옮기면 링크를 수정해야 합니다.) 

머신 러닝 관련 자료는 [Machine Learning](../_draft/2016-03-07-Machine-Learning.md) 글을 참고하시기 바랍니다. (나중에 포스트로 옮기면 링크를 수정해야 합니다.) 

### 참고 자료

[^get_started]: [Get Started](https://www.tensorflow.org/get_started/)

[^anaconda_installation]: [Anaconda installation](https://www.tensorflow.org/get_started/os_setup#anaconda_installation)

[머신러닝 초보를 위한 MNIST](https://codeonweb.com/entry/12045839-0aa9-4bad-8c7e-336b89401e10) : MNIST 는 간단한 컴퓨터 비전 데이터 세트로, 손으로 쓰여진 이미지들로 구성되어 있다고 합니다.

[^conda-forge]: [conda-forge/tensorflow-feedstock](https://github.com/conda-forge/tensorflow-feedstock)

[^test_the_tensorflow_installation]: [Test the TensorFlow installation](https://www.tensorflow.org/get_started/os_setup#test_the_tensorflow_installation)