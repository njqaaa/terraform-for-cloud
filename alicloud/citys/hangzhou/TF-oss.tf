module "oss-hfjy-test12345" {
  source = "../../modules/oss-object"

  region      = var.region
  bucket_name = "hfjy-test12345"
  acl         = var.acl
  # acl               = "public-read"
  # bucket            = "hfjy-test12345"
  # creation_date     = "12106-10-10"
  # extranet_endpoint = "oss-cn-hangzhou.aliyuncs.com"
  # force_destroy     = false
  # id                = "hfjy-test12345"
  # intranet_endpoint = "oss-cn-hangzhou-internal.aliyuncs.com"
  # location          = "oss-cn-hangzhou"
  # logging_isenable  = false
  # owner             = "1575044515408894"
  # storage_class     = "Standard"
}
