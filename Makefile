install_gitlab:
	kubectl -n gitlab apply -f ./manifests/gitlab-psql-password-secret.yaml
	helm upgrade -n gitlab --install gitlab -f gitlab.yaml ./gitlab
install_runner:
	helm upgrade -n gitlab --install gitlab-runner -f gitlab-runner.yaml ./gitlab-runner
uninstall_gitlab:
	helm uninstall gitlab 
	kubectl delete pvc --all
uninstall_runner:
	helm uninstall gitlab-runner
template_gitlab:
	helm template -n gitlab gitlab -f gitlab.yaml ./gitlab > gitlab-template.yaml
template_runner:
	helm template gitlab-runner -n gitlab -f gitlab-runner.yaml ./gitlab-runner > gitlab-runner-template.yaml
scale0:
	./hack/scale.sh 0
scale1:
	./hack/scale.sh 1