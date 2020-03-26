We are hosting our infrastructure as IaC on [Open Telekom Cloud][0] using [Terraform][2] for automated lifecycle management.

The [OTC provider][3] is utilized and [terraform state][4] is shared via an OTC OBS [S3 bucket][5] without locking capability. 

### Install `terraform`
```bash
sudo sh -c "wget -qO- https://releases.hashicorp.com/terraform/0.12.24/terraform_0.12.24_linux_amd64.zip |\
            gunzip - > /usr/local/bin/terraform;\
            chmod a+x /usr/local/bin/terraform"
```

### Create  `~/.otc/credentials`
```bash
export OTC_REGION=eu-de
export OTC_PROJECT=...
export OTC_DOMAIN=OTC-...
export OTC_ACCESS_KEY=...
export OTC_SECRET_KEY=...
```

### Checkout your IaC and start the flow
```bash
git clone https://github.com/dta4/commons
cd commons/otc

./terraform init
./terraform plan
./terraform apply
./terraform destroy
```

### Todo

- [ ] find a way for remote state locking
- [ ] define infrastructure as modules `tags`, `network`, `CCE`, `RDS`, `ECS`, ...
- [ ] use [GitOps][8] together with terraform [workspaces][7]
- [ ] [automate][6]
- [ ] ...

[0]: https://www.t-systems.com/de/de/cloud-und-infrastructure/it-effzient-managen/open-telekom-cloud
[1]: https://www.terraform.io/
[2]: https://www.terraform.io/intro/vs/cloudformation.html
[3]: https://www.terraform.io/docs/providers/opentelekomcloud
[4]: https://www.terraform.io/docs/state/remote.html
[5]: https://www.terraform.io/docs/backends/types/s3.html
[6]: https://learn.hashicorp.com/terraform/development/running-terraform-in-automation
[7]: https://www.terraform.io/docs/state/workspaces.html
[8]: https://www.weave.works/technologies/gitops/

> Written with [StackEdit](https://stackedit.io/).
