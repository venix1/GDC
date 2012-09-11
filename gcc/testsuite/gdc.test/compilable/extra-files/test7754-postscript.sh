#!/usr/bin/env bash

grep -v "D import file generated from" ${RESULTS_DIR}/compilable/test7754.di > ${RESULTS_DIR}/compilable/test7754.di.2
diff --strip-trailing-cr compilable/extra-files/test7754.di ${RESULTS_DIR}/compilable/test7754.di.2
if [ $? -ne 0 ]; then
    exit 1;
fi

rm ${RESULTS_DIR}/compilable/test7754.di{,.2}

