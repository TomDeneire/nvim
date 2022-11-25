#!/bin/sh
export CURRENT_FILE=%:p && export QPATH=$(qtechng file tell $CURRENT_FILE --jsonpath='$..DATA..qpath' --unquote) && export PREVIOUS=$(qtechng registry get "qtechng-releases" | awk '{print $(NF-1)}') && mkdir -p $PREVIOUS && cd $PREVIOUS && qtechng source co $QPATH --version=$PREVIOUS && meld $(qtechng file tell $CURRENT_FILE --jsonpath='$..DATA..relpath' --unquote) $CURRENT_FILE
