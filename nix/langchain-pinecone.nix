{
  lib,
  buildPythonPackage,
  pythonOlder,
  fetchFromGitHub,
  pdm-backend,
  langchain-core,
  pinecone-client,
  langchain-tests,
  pytestCheckHook,
  pytest-asyncio,
  syrupy,
  gitUpdater,
}:

buildPythonPackage rec {
  pname = "langchain-pinecone";
  version = "0.2.3";
  pyproject = true;

  disabled = pythonOlder "3.9";

  src = fetchFromGitHub {
    owner = "langchain-ai";
    repo = "langchain";
    tag = "langchain-pinecone=${version}";
    hash = "";
  };

  sourceRoot = "${src.name}/libs/partners/pinecone";

  build-system = [
    pdm-backend
  ];

  pythonRelaxDeps = [
    # Each component release requests the exact latest core.
    # That prevents us from updating individual components.
    "langchain-core"
  ];

  dependencies = [
    langchain-core
    # pinecone-client
  ];

  nativeCheckInputs = [
    langchain-tests
    pytestCheckHook
    # pytest-asyncio
    # syrupy
  ];

  enabledTestPaths = [ "tests/unit_tests" ];

  pythonImportsCheck = [ "langchain_pinecone" ];

  passthru = {
    # python updater script sets the wrong tag
    skipBulkUpdate = true;
    updateScript = gitUpdater {
      rev-prefix = "langchain-pinecone==";
    };
  };

  meta = {
    changelog = "https://github.com/langchain-ai/langchain/releases/tag/${src.tag}";
    description = "Integration package connecting Pinecone and LangChain";
    homepage = "https://github.com/langchain-ai/langchain/tree/master/libs/partners/pinecone";
    license = lib.licenses.mit;
    maintainers = with lib.maintainers; [ Luflosi ];
  };
}
