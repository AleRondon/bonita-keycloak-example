#!/bin/sh

set -euxo pipefail


BONITA_PATH=/opt/bonita


cd ${BONITA_PATH} 



find setup/platform_conf/initial -name "*.properties" | xargs -n10 sed -i \
    -e 's/^#.*authentication.service.ref.name=.*/'"authentication.service.ref.name=passphraseOrPasswordAuthenticationService"'/'  \
    -e 's/^#.*authentication.service.ref.passphrase=.*/'"authentication.service.ref.passphrase=Bonita"'/' \
    -e 's/^#.*authentication.passphraseOrPasswordAuthenticationService.createMissingUser.enable=.*/'"authentication.passphraseOrPasswordAuthenticationService.createMissingUser.enable=true"'/' \
    -e 's/^#.*bonita.runtime.authentication.passphrase-or-password.create-missing-user.addDefaultMembership.enabled=.*/'"bonita.runtime.authentication.passphrase-or-password.create-missing-user.addDefaultMembership.enabled=false"'/' \
    -e 's/^#.*bonita.runtime.authentication.passphrase-or-password.create-missing-user.createUserGroupsAndRole.enabled=.*/'"bonita.runtime.authentication.passphrase-or-password.create-missing-user.createUserGroupsAndRole.enabled=true"'/'

find conf -name "log4j2-loggers.xml" | xargs -n10 sed -i \
    -e '/^.*<\/Loggers>/ i\<Logger name="org.keycloak" level="ALL" \/>'  \
    -e '/^.*<\/Loggers>/ i\<Logger name="class org.keycloak" level="ALL" \/>'  \
    -e '/^.*<\/Loggers>/ i\<Logger name="com.bonitasoft.engine.authentication" level="ALL" \/>'  \
    -e '/^.*<\/Loggers>/ i\<Logger name="org.bonitasoft.console.common.server.auth" level="ALL" \/>'

cp -f /opt/custom-config.d/authenticationManager-config.properties  setup/platform_conf/initial/tenant_template_portal/authenticationManager-config.properties
cp -f /opt/custom-config.d/keycloak-oidc.json  setup/platform_conf/initial/tenant_template_portal/keycloak-oidc.json
cp -f /opt/custom-config.d/keycloak-saml.xml setup/platform_conf/initial/tenant_template_portal/keycloak-saml.xml
cp -f /opt/custom-config.d/user-creation-attribute-mapping-custom.properties setup/platform_conf/initial/tenant_template_portal/user-creation-attribute-mapping-custom.properties
cp -f /opt/custom-config.d/user-creation-group-mapping.properties setup/platform_conf/initial/tenant_template_portal/user-creation-group-mapping.properties
cp -f /opt/custom-config.d/user-creation-group-profile-mapping.properties setup/platform_conf/initial/tenant_template_portal/user-creation-group-profile-mapping.properties
cp -f /opt/custom-config.d/security-config.properties setup/platform_conf/initial/platform_portal/security-config.properties
