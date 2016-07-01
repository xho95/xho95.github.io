SceneKit은 애플에서 앱 개발에 사용할 수 있는 상위 레벨의 3D 프레임웍입니다.[^WWDC_2013]  [^WWDC_2014]  [^WWDC_2015]

여기서는 WWDC 2016의 Advances in SceneKit Rendering 세션에서 소개된 내용을 정리합니다.[^WWDC_2016]

WWDC 2016에서는 SceneKit에 큰 변화는 없는 것 같고, 주로 Rendering 부분에서 성능이 개선된 것 같습니다.

다만, watchOS에도 SceneKit이 적용되면서 SceneKit은 애플의 모든 OS에서 사용할 수 있게 되었습니다.

### 앞부분

Linear Rendering and Color Management

색을 사용할 때는 주의가 필요하다.

설정에서 사용을 선택할 수 있다.

보다 넓은 범위의 색을 사용할 수 있는 것 같습니다. Wide Gamut에 대해서 좀 더 살펴볼 필요가 있습니다. 

### Physical Rendering

새로 추가된 속성은 다음과 같습니다. 

#### Pysically Based Materials

Pysically Based Materials 에는 두 가지가 추가되었습니다. 

* metalness 
* roughness

사용 예는 아래와 같습니다. 
다만 사용하려면, metalness map과 roughness map을 만들어야 적용할 수 있습니다. 

```
let material = SCNMaterial()

material.lightingModelName = .physicallyBased
material.diffuse.contents = "albedo.png"
material.metalness.contents = "metalness.png"
material.roughness.contents = "roughness.png"
```

roughness의 경우 scalar 값으로도 설정할 수 있습니다.

#### Pysically Based Lights

##### Image based Lighting 

아래처럼 하면 주변 이미지가 물체에 작용하는 조명효과를 줄 수 있습니다. `exr` 확장자는 무슨 의미인지 잘 모르겠습니다. 

```
let scene = SCNScene()

scene.lightingEnvironment.contents = "outside.exr"
scene.background.contents = scene.lightingEnvironment.contents
```

일단은 주변 이미지를 주변광으로 설정하고, 다시 이 주변광으로 설정한 이미지를 주변 이미지로 세팅하고 있는 것 같습니다. 

##### Light probes

국부적인 조명 효과를 주는 것 같습니다. 

```
let light = SCNLight()

light.type = .probe
```

##### Point lights

* Intensity

조명의 밝기를 조절할 수 있습니다. lumence와 Kelvin 두가지 단위로 조절 가능한 것 같습니다.

```
let light = SCNLight()

light.intensity = 15000 		// defaults to 1000 lm
light.temperature = 5000		// Kelvin
```

* Photometric lights

`IES`라는 용어도 쓰는데 그건 뭔지 모르겠습니다. 

```
let light = SCNLight()

light.type = .IES
light.iesProfileURL = Bundle.main().urlForResource("spot", withExtensions: "ies")
```

### HDR Camera

HDR (High Dynamic Range) 부분이 추가되었습니다.

마치 실제 카메라의 조리개를 조작하거나 필터 등을 적용한 듯한 효과를 줄 수 있는 것 같습니다. 

```
let camera = SCNCamera()

camera.wantsHDR = true
```

#### Bloom

특정 위치에 반짝거림을 주는 효과인 것 같습니다. 

```
camera.bloomThreshold = 0.5
camera.bloomIntensity = 1.5
camera.bloomBlurRadius = 2.5
```

#### Motion Blur

화면에 이동 효과를 주는 것 같습니다.

```
camera.motionBlurIntensity = 0.2
```

때에 따라서 이동 효과를 적용하지 않는 대상을 지정할 수 있습니다.

```
character.movabilityHint = .movable
```

#### Vignetting

카메라 주변부를 흐리게 하여 집중도를 높이는 효과를 줄 수 있습니다.

```
camera.vignettingPower = 0.2
camera.vignettingIntensity = 1.2
```

#### Color Fringe

카메라 렌즈의 색수차 같은 효과도 줄 수 있는 것 같습니다. 이게 왜 필요한지는 아직 모르겠습니다.

```
camera.colorFringeStrength = 0.2
camera.colorFringeIntensity = 0.8
```

#### Color Correction

색 보정 효과를 줄 수 있습니다. 채도(saturation)와 대비(contrast) 효과를 줄 수 있습니다.

* Saturation
* Contrast

```
camera.saturation = 0.0
camera.contrast = 2.0
```

#### Color Grading

색 조정 효과를 주는 것 같습니다. 
특정 색 집합으로 된 화면을 다른 색 집합으로 된 화면으로 바꾸는 방식인 것 같습니다.  (정확하지는 않습니다.)

```
camera.colorGrading = "colorProfile.png"
```

### I/O improvements

#### Polygons

모델 로딩 시에 방향을 원본으로 유지할 수 있는 것 같습니다. 
```
let loadingOptions = [.preserveOriginalTopology: true]
```

#### Support for USD files

3D 데이터를 쉽게 교환할 수 있는 것 같습니다.

USD (Universal Scene Description) 포맷을 지원하게 된 것 같습니다. USD 포맷은 새로운 open standard 포맷으로 픽사에서 사용하고 있다고 합니다. Concurrent workflow도 지원하는 포맷입니다.

##### Classes

하나의 모델로 다양한 물체를 변주해서 만들 수 있는 것 같습니다. 

##### Capabilities

애니메이션 효과도 있는 것 같습니다. (좀 더 살펴봐야 합니다.)


### 고찰하기

WWDC 2016 이전 자료들도 참고하여 SceneKit 자체의 내용을 따로 정리할 예정입니다.

### 참고 자료

[^WWDC_2013]: [What's New in SceneKit](https://developer.apple.com/videos/play/wwdc2013/500/)

[^WWDC_2014]: [What's New in SceneKit](https://developer.apple.com/videos/play/wwdc2014/609/)

[^WWDC_2015]: [Enhancements to SceneKit](https://developer.apple.com/videos/play/wwdc2015/606/)

[^WWDC_2016]: [Advances in SceneKit Rendering](https://developer.apple.com/videos/play/wwdc2016/609/)

[^RayWenderlich]: [Scene Kit Tutorial with Swift Part 1: Getting Started](https://www.raywenderlich.com/128668/scene-kit-tutorial-with-swift-part-1)
