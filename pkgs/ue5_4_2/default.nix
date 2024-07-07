{
  buildGoModule,
  fetchFromGitHub,
}:
buildGoModule rec {
  pname = "terraform-graph-beautifier";
  version = "0.3.3";
  vendorHash = "sha256-Znas0FCA4QfIjrNXbc8sKEQhqXMeYZucOJSID0qjVLo=";

  src = fetchFromGitHub {
    owner = "pcasteran";
    repo = "terraform-graph-beautifier";
    rev = "v${version}";
    hash = "sha256-UmN0YsELaichtwINtHIKtA8uDhRqsuLjQ4wRAeJx0Ws=";
  };

  meta = {
    description = "Command line tool allowing to convert the barely usable output of the terraform graph command to something more meaningful and explanatory.";
    homepage = "https://github.com/pcasteran/terraform-graph-beautifier";
    changelog = "https://github.com/pcasteran/terraform-graph-beautifier/releases/v${version}/";
  };
}
