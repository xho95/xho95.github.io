---
layout: post
title:  "Kalman Filter 특강 정리"
date:   2016-04-23 17:30:00 +0900
categories: Modulabs Study KalmanFilter Probability
---


### Kalman Filter

kalman filter - 확률 기반 시스템

동적 모델과 센서 데이터를 결합해주는 방법(?)

필터 - outlier를 제거해주는 역할도 하기 때문(?)

othometry - 바퀴 회전수를 이용하여 자신의 위치를 추측, 자동차 미터기 - odometry - 모델링할 때 쓴다. 모델 결과와 실제 위치의 오차로 모델의 오차를 구한다(?), 노이즈 모델링

오차, 노이즈 누적을 감소시켜준다.

#### 확장 칼만 필터

navigation의 표준이라고 볼 수 있다.

#### 확률

랜덤 변수

확률 해석 - 확률 변수에 대한 개념이 필요

확률 변수 - 값을 넣는게 아니라, 함수안에 함수를 넣는 개념

확률 분포의 정의역 축에 해당하는 전체 변수들을 묶에서 확률 변수라고 한다. (다시 정리하자.)

PDF

CDF - PDF 누적함수

#### mechanism

예측값 - 모델에 의해 결정되는 값(?), 측정값 - 센서로부터 오는 값(?)

#### 수식

xk hat = 예측값
pk hat = 공분산 - kalman gain 계산

바(-) 첨자 : 보정되기 전의 값임을 의미 - 보정은 에러를 보정함을 의미한다.

markoff(?) 등과 같이 다음 상태를 예측하기 위한 모델
decision tree  

#### 물체의 상태 - 상태 방정식

dynamic model

거리 <- 속도, 가속도 + 초기값(?) - 가속도는 제어 입력, 초기값은 이전 상태값
시간 t -> 델타 t : 상수이다.

행렬 -> 상태 방정식

샘플링을 결정하면 모델에 들어간다(?)

xt = A xt-1 + B ut

zk : 측정해서 나오는 값(?)

gradient decent - 상태 방정식과도 관련있다.

A = 1, B = -uek 일 경우 gradient decent와 같은 방식 - 1차원(?)

#### 공분산

분산 여러개를 매트릭스로 만든 것(?)

하나의 다차원 분산을 축당 성분으로 프로젝션 한 것을 매트릭스로 만든 것이다(?)

#### 기대값

가정(?) - 가우시안 노이즈 적용

Xt = Axt-1 + But + wt - 분포

wt : 가우시안 노이즈 - 가우시안 값을 넣는다. - random variable

xt hat : 분포상의 하나의 값(?)

#### 공분산

현재 상태의 공분산 -> 이전 상태의 확률을 통하여 지금 상태의 공분산을 구하고 싶다.

un corelate - 신호에서는 노이즈를 이렇게 가정 - 서로 직교한다는 의미

E [x^Ty] = 0

E [wt^2] = Q 로 치환 - 노이즈의 분산 - 모델 오차와 관련

#### Kalman gain

가우시안 두개를 합치는 것과 유사한 과정(?)

가우시안의 장점 : 가우시안과 가우시안을 곱하면 가우시안

두 가우시안 곱을 통해서 새로운 평균, 분산을 구할 수 있다. - 기존 두개의 평균과 두 개의 분산을 통해서 바로 구할 수 있다.

mu f, sigma f

H : scaling factor(?) - 차원을 맞춰주는 역할 - 비례 상수와 같은 개념

H는 보통 I가 될 수 있다. - 차원이 같을 경우(?)

R : 측정기 device (sensor)의 공분산 - 센서의 오차범위 등으로 주어지는 값(?)

K = H sigma

kalman gain이 높다. - 모델의 분산이 높다. - 모델의 식을 안 믿고 측정을 믿게 된다.

kalman gain이 낮다. - 센서의 분단이 높다. -

outlier - 모델 분산이 높으면 outlier를 따라가게 됨. - kalman gain으로 튜닝

#### Kalman Filter

zk - xk hat~ 을 가지고 보정하고 싶다는 의미 -> 새로운 xk hat 이 된다. (보정된 값)

w = winner solution (???) - normal equation = cross corelation / auto corelaton

R^-1 * P

zk, xk uncorelate 로 가정

#### 분산

두 개의 분산을 더하면 분산이 더 작게 나온다. - 조화 평균(?)

두 저항을 병렬 연결하면 저항이 작아지는 것과 같은 성질
