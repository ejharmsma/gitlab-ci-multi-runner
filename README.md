# gitlab-ci-multi-runner
Minimal Alpine based Gitlab CI Multi Runner container that supports docker-in-docker builds


## Simple manual Docker in Docker setup
1. Start helper container with `dockerd` socket:

   **Important**: container runs in privileged mode, for security consequences see: https://docs.docker.com/engine/reference/run/#/runtime-privilege-and-linux-capabilities
   
    ```
    docker run --restart always --privileged --name some-docker -d docker:dind
    ```
2. Configure new GitLab CI Runner, config file will be stored at volume location:

    ```
    docker run -it --rm -v /srv/my-ci-runner-config:/gitlab-config ejharmsma/gitlab-ci-multi-runner register
    ```
    
    And fill in the registration questions. Or for example in unattended mode:
    
    ```
    docker run -it --rm -v /srv/config:/gitlab-config ejharmsma/gitlab-ci-multi-runner register -n --name MY_RUNNER_NAME -u https://gitlab.com/ci -r MY_REGISTER_TOKEN --executor docker --docker-image busybox
    ```
    
3. Start runner in background (and link to dockerd container of step 1)

    ```
    docker run -v /srv/my-ci-runner-config:/gitlab-config --restart always -d --link some-docker:docker ejharmsma/gitlab-ci-multi-runner
    ```

## Docker / Rancher compose
TODO
