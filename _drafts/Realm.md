
다음과 같은 에러에 대한 해결 방법입니다.

```
error: module importing failed: invalid token (rlm_lldb.py, line 37)
  File "temp.py", line 1, in <module>

2020-05-22 13:19:18.818658+0900 Space Caravan[12200:474733] Metal GPU Frame Capture Enabled

2020-05-22 13:19:18.819188+0900 Space Caravan[12200:474733] Metal API Validation Enabled

2020-05-22 13:19:19.705454+0900 Space Caravan[12200:474733] [plugin] AddInstanceForFactory: No factory registered for id <>

2020-05-22 13:19:21.398955+0900 Space Caravan[12200:474733] SKView: ignoreRenderSyncInLayoutSubviews is NO. Call _renderSynchronouslyForTime without handler

2020-05-22 13:19:24.580190+0900 Space Caravan[12200:474733] [Error] _authenticateUsingAlert:Failed to authenticate player with existing credentials.Error: Error Domain=GKErrorDomain Code=6 "The requested operation could not be completed because local player has not been authenticated." UserInfo={NSLocalizedDescription=The requested operation could not be completed because local player has not been authenticated.}

2020-05-22 13:19:24.664608+0900 Space Caravan[12200:474733] [Account Error] startAuthenticationForExistingPrimaryPlayer:Failed to Authenticate player.Error: Error Domain=GKErrorDomain Code=3 "The requested operation could not be completed due to an error communicating with the server." UserInfo={NSLocalizedDescription=The requested operation could not be completed due to an error communicating with the server.}
```

위에서 다음은 [error: module importing failed: invalid token (rlm_lldb.py, line 37) File "temp.py", line 1, in <module>](https://github.com/realm/realm-cocoa/issues/6367) 에 해결 방법이 있습니다.   

```
error: module importing failed: invalid token (rlm_lldb.py, line 37)
  File "temp.py", line 1, in <module>
```

다음은 [SKView: ignoreRenderSyncInLayoutSubviews is NO. Call _renderSynchronouslyForTime without handler](http://quabr.com:8182/58664447/skview-ignorerendersyncinlayoutsubviews-is-no-call-rendersynchronouslyfortime) 를 참고할만 합니다. `SKView` 와 관련된 에러라고 합니다. 단 해결 방법은 없습니다.

```
... SKView: ignoreRenderSyncInLayoutSubviews is NO. Call _renderSynchronouslyForTime without handler
```

### 참고 자료

[error: module importing failed: invalid token (rlm_lldb.py, line 37) File "temp.py", line 1, in <module>](https://github.com/realm/realm-cocoa/issues/6367)

[SKView warning logs](https://stackoverflow.com/questions/58923683/skview-warning-logs)
