# Bonita test with SSO  #

This project provides a docker compose with Keycloak server and a Bonita configured for OIDC (that can be switched to SAML easily).

## Configuration ##
Put your Bonita license in `bonita/lic`

Requirement:


Note:

 * The hosts file must be modified as described below to add hosts ```bonita-sso``` and ```keycloak```      
``` shell
127.0.0.1       keycloak
127.0.0.1       bonita-sso
```

* The network ``` docker_bonita_backend``` should be created automatically. If not, run:
```shell
 docker network create docker_bonita_backend 
```





Note:

* By default, the docker-compose starts a **bonita 8.0-SNAPSHOT**, it could be changed easily by changing the section bellow in `docker-compose.yml` file
```
bonita:
 image: (put the right image you want to test)
```
* to switch to SAML just update `bonita/conf/anthenticationManager-config.properties` to uncomment `saml` prop and comment `oidc` 
* to switch to  `discovery` mode :
  * rename `keycloak-oidc.json` to `keycloak-oidc-basic-mode.json`
  * rename `keycloak-oidc-with-discovery-to-rename.json`  to `keycloak-oidc.json`


## Execution
At root level once the build is successful run :

    docker-compose up
    
Then go to: 
- http://bonita-sso:8080/bonita/login.jsp to login with the technical user account
- http://bonita-sso:8080/bonita to login with walter.bates/bpm or helen.kelly/bpm or william.jobs/bpm on Keycloak (user groups role and profile mapping should be created automatically in bonita for those users)
- http://bonita-sso:9090/admin to login with admin/admin on keycloak admin console

To scratch database and restart from clean container use

    docker-compose down
    
To pull the newest versions of bonita or keycloak docker images use

    docker-compose pull
