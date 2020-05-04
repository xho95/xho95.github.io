### ready

#### select

[Aquire a default value of a “select” HTML Input Element, via jQuery & JavaScript?](http://stackoverflow.com/questions/7403632/aquire-a-default-value-of-a-select-html-input-element-via-jquery-javascript)

```
$(document).ready(function() {
    $("select").each(function() {
        $(this).data("originalValue", $(this).val());
    });

    // Log data - will output "1"
    $("select").each(function() {
        console.log($(this).data("originalValue"));
    });
});
```

ready를 어떻게 사용하는지는 좀 더 정리해 봐야하겠습니다.

### 최신 버전 사용

[JQuery 항상 최신 버전으로 사용하기!](http://lehero.tistory.com/236)

### Error

[ReferenceError: Can't find variable: $](http://stackoverflow.com/questions/21417836/referenceerror-cant-find-variable) : You have to import jQuery before using it

