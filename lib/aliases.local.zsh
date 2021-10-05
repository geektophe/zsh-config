# S3 on filerinfra
alias s3="aws --profile chriss s3 --endpoint https://s3.infra.dailymotion.com"
alias s3_admin="aws --profile infra s3 --endpoint https://s3.infra.dailymotion.com"
alias gpg="gpg2"
alias ldapvi="ldapvi -D 'cn=Christophe Simon,ou=admin,dc=dailymotion,dc=com' --host ldaps://ldap-master.vip.dailymotion.com"
alias pkg_add="doas pkg_add"
alias pkg_delete="doas pkg_delete"
alias rcctl="doas rcctl"
alias vim=nvim
alias vimdiff=nvim -d
#alias alfred="ssh chriss -L 5555:localhost:5555 bin/alfred"
#alias kubectl="ssh chriss kubectl"
#alias stern="ssh chriss bin/stern"

dailysign() {
	git config user.signingkey C94A49FEDFA460AD
	git config user.email christophe.simon@dailymotion.com
}

saltdevsync() {
	rsync -av --delete ~/git/salt/ saltdev-01.adm.dc3.dailymotion.com:/home/chriss/salt/
}
