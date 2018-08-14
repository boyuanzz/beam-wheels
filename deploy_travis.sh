# Define custom utilities for deploying on travis

function deploy {
  cd ${TRAVIS_BUILD_DIR}/wheelhouse
  svn co ${BEAM_SVN_DIR}/${VERSION}
  for artifact in *.whl; do
    echo $artifact
    mv $artifact ${VERSION}/${PYTHON_ARTIFACTS_DIR}/$artifact
    svn add ${VERSION}/${PYTHON_ARTIFACTS_DIR}/$artifact
    cd ${VERSION}
    svn commit --non-interactive --no-auth-cache --username "$APACHE_USERNAME" --password "$APACHE_SECRET" -m "Upload python wheels"
    cd ..
  done
}
