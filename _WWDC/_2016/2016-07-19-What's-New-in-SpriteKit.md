## What's New in SpriteKit

* WWDC 2016의 What's New in SpriteKit 영상을 정리한 글입니다.[^610]

### What is SpriteKit?

* 2D graphics framework for games
* watchOS 지원

* live editor : visually lay out
* built-in Metal

#### Scene Outline View

* scene hierarchy view (?) : new

#### GameplayKit Integration

* Entities and Components : new
* Pathfinding : Navigation graph editor - new

#### FPS Performance Gauge

* Real-time performance breakdown : new

#### Tile Maps

* a grid of evenly spaced images : new

##### Demo

* Enable Automapping
* Advanced Tile Set : Variance
* Animation
* Scale, Rotate
* Hexa Tile
* Tile Removing

#### Tile Maps

* `SKTileMapNode` : 
* `SKTileSet` : 
* `SKTileGroup` : 
* `SKTileGroupRule` : how to interact
* `SKTileDefinition` : 

#### Tile Type

* Grid
* Isometric
* Hexagonal

### Warp Transformation

#### Introduction

* Scale
* Rotation
* Custom Shader

* `SKWarpGeometry` : new
	* Squash
	* Stretch
	* Keyframe-based animations

#### Concept

* subdivision

### Per-Node Attributes for Custom Shaders

* `SKAttributes` : new

### Focus Interaction on Apple TV

#### Introduction

* UIKit

#### SpriteKit 

* Integrated with SpriteKit : new
* `UIFocusEnvironment` : new

#### SpriteKit on AppleWatch : new

* available for AppleWatch
* `WKInterfaceSKScene` : new
* Effect 등에서 사용할 수 있는 class 등이 조금 다릅니다. 나중에 확인이 필요합니다!

### SpriteKit Tips & Tricks

#### Asset Catalog

* Use sprite atlas : minimal draw calls

#### Performance

* renders when necessary : new
* `preferredFramePerSecond` : new(?)

### 관련 영상


### 참고 자료

[^610]: [WWDC 2016 610: What's New in SpriteKit](https://developer.apple.com/videos/play/wwdc2016/610/)






