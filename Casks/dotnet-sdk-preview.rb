cask "dotnet-sdk-preview" do
  if Hardware::CPU.intel?
    version "6.0.100-preview.2.21155.3,5e10dc75-294e-49f4-972e-218ae86191a3:e46d3533c30c8a864252a334820263a9"
    sha256 "626c3c9beed8bf64797838ccebbc05cae5dc7cf28ebc741e444f45d7c0ed03b3"

    url "https://download.visualstudio.microsoft.com/download/pr/#{version.after_comma.before_colon}/#{version.after_colon}/dotnet-sdk-#{version.before_comma}-osx-x64.pkg"
  else
    version "6.0.100-preview.2.21155.3,e5cbc909-e705-4bc1-9327-15c9f905a149:6da57e95a58cef98444698fa72378e23"
    sha256 "9d9c6fc1a829a40222271c8b312368195dd2a771791120b33ab5a03cebdcc843"

    url "https://download.visualstudio.microsoft.com/download/pr/#{version.after_comma.before_colon}/#{version.after_colon}/dotnet-sdk-#{version.before_comma}-osx-arm64.pkg"
  end

  appcast "https://dotnet.microsoft.com/download/dotnet/#{version.major_minor}"
  name ".NET SDK"
  desc "Preview release of the .NET SDK"
  homepage "https://dotnet.microsoft.com/"

  conflicts_with cask: [
    "dotnet",
    "dotnet-sdk",
    "dotnet-preview",
  ]
  depends_on macos: ">= :sierra"

  if Hardware::CPU.intel?
    pkg "dotnet-sdk-#{version.before_comma}-osx-x64.pkg"
  else
    pkg "dotnet-sdk-#{version.before_comma}-osx-arm64.pkg"
  end
  binary "/usr/local/share/dotnet/dotnet"

  uninstall pkgutil: [
    "com.microsoft.dotnet.*",
    "com.microsoft.netstandard.pack.targeting.*",
  ],
            delete:  [
              "/etc/paths.d/dotnet",
              "/etc/paths.d/dotnet-cli-tools",
            ]

  zap trash: [
    "~/.dotnet",
    "~/.nuget",
  ]
end
