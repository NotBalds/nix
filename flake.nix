{
	description = "NotBalds flake - place of NotBalds' nix things.";

	inputs = {
		nixpkgs.url = "github:NixOS/nixpkgs";
		cwe-server.url = "github:NotBalds/cwe-server/v0.3.0";
		cwe-cli.url = "github:NotBalds/cwe-client-cli/v0.3.0";
		bald.url = "github:NotBalds/bald";
		bal.url = "github:NotBalds/bal";
	};

	outputs = { nixpkgs, ... }@inputs: {
		packages = (nixpkgs.lib.listToAttrs (nixpkgs.lib.forEach ["aarch64-linux" "x86_64-linux"] (system: {
			name = system;
			value = {
				cwe-server = inputs.cwe-server.packages.${system}.default;
				cwe-client-cli = inputs.cwe-cli.packages.${system}.default;
				bald = inputs.bald.packages.${system}.default;
				bal = inputs.bal.packages.${system}.default;
			};
		})));
		nixosModules = {
			cwe-server = inputs.cwe-server.nixosModules.cwe_server;
		};
	};
}
