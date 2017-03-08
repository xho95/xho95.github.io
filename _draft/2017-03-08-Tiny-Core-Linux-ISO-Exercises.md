### 매뉴얼 변형 방식

매뉴얼에서는 cde 디렉토리를 배제하는 방식이라 매뉴얼대로 하되 `cp -a /mnt/tmp/boot ~/Documents/temp` 를  `cp -a /mnt/tmp/boot ~/Documents/temp` 로 대체

core.gz 를 새로 만들면 일단 압축 문제인지 뭔가 작동이 안됩니다.

### core.gz 를 손대지 않는 방식

압축을 풀면 cfg 파일은 isolinux 디렉토리에 있으므로 cfg 파일만 손댈 경우 core.gz 파일을 손대지 않고 ISO 파일을 만들 수 있습니다.  

이렇게 하면 ISO 파일이 정상 작동합니다.