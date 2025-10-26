final: prev: {
  pythonPackagesExtensions = prev.pythonPackagesExtensions ++ [
    (python-final: python-prev: {
      langchain-pinecone = python-final.callPackage ./langchain-pinecone.nix { };
    })
  ];
}
