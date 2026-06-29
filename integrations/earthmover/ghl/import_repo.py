"""Import existing icechunk repositories into arraylake."""

from arraylake import Client

client = Client()

client.import_repo(
    "space-intelligence/ghl",
    bucket_config_nickname="si-az-earthmover",
    prefix="ghl/2025/v1",
)

