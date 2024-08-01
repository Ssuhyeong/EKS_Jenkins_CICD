# EKS bitbucket CI/CD 구축

<aside>
  
💡 CI 란? ( Continuous Integration )
- 지속적이 통합이 제대로 구현되면 애플리케이션 코드의 새로운 변경 사항이 정기적으로 빌드 및 테스트를 거쳐 공유 repo에 병합됩니다. 여러명의 개발자가 동시에 애플리케이션 개발과 관련된 코드 작업을 할 경우 서로 충돌하는 문제를 해결한다.
  
💡 CD란? ( Continuos Delivery )
- 개발자 변경 사항을 repo에서 고객이 사용 가능한 프로덕션 환경까지 자동으로 릴리스 하는 것을 의미한다.
  
</aside>

<br/>
<br/>

# EKS ( Elastic Kubernetes Service )?

- AWS 매니지드 서비스를 사용하다 보면 커스터마이징을 하는 부분에 제약이 많다.
- EKS를 사용하면 그러한 제약이 없도록 구성하여 이식성을 그대로 가져갈 수 있도록 구성되었다.
    - 클라우드 환경에서 k8s를 서비스 해주면 “managed Kubernetes”라고 불리며 관리형 쿠버네티스인데 Control panel을 클라우드 서비스 벤더사에서 관리해준다.
    - EKS는 AWS에서 제공하는 “Managed Kubernetes”이다.
        - 쿠버네티스를 구축하고 관리할 때는 마스터 노드 및 etcd를 이중화, 삼중화 하는것이 매우 중요하다. 하지만 EKS에서는 마스터노드와 etcd 노드를 관리해주고 Private Link로 연결되어 내부망 통신으로 안전하고 워커노드와 통신 할 수 있다.

![image](https://github.com/user-attachments/assets/50e30e05-cd4a-420a-9974-2d76d7bebba6)

<br/>
<br/>

# CI / CD 파이프라인 아키텍처

![Group 32956](https://github.com/user-attachments/assets/aea758d4-7cad-4c29-a105-672b203e2fe2)

- 개발자가 bitbucket에 코드를  PUSH하고.
- Jenkins를 bitbucket에 연결하고, Jenkins는 bitbucket repository에 commit된 내용을 감지한다.
- Pipeline을 생성하고 bitbucket에 위치한 Jenkinsfile 스크립트를 찾아 자동 실행되게 설정한다.
- Dockerfile을 참조해 image를 빌드한다.
- Docker image를 참조해 image를 빌드한다.
- Docker image를 Docker Hub에 push한다.
- Jenkins에서 manifest를 업데이트해 image tag를 수정한다.
- argoCD에서 image tag 수정을 감지하고 싱크 한다.
- argoCD에서 docker image pull을 진행한다.
- argoCD에서 소스 코드에서 변경된 부분을 반영하여 업데이트하거나 피드를 재생성한다.

<br/>
<br/>

### Jenkins pipeline

![image](https://github.com/user-attachments/assets/123ca127-3375-4d9c-980c-de847edded14)

### Slack 연동

![image](https://github.com/user-attachments/assets/92d6ed08-4836-4497-aee9-c063eb2ecbb3)


### AlgoCD

![image](https://github.com/user-attachments/assets/cf865b7b-7102-4036-9b0d-ea4e44140196)

### 배포
![image](https://github.com/user-attachments/assets/45f43880-70d7-4d19-9784-585035305d03)
