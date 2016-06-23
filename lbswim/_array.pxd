from cpython cimport Py_buffer
from dq cimport *

cdef extern from "target/array.h" namespace "target":
    cdef cppclass array[T, N]:
        pass

cdef extern from "target/NdArray.h" namespace "target":
    cdef cppclass SpaceIndexer[NDIM]:
        array[size_t, NDIM] shape
        array[size_t, NDIM] strides
        size_t size
  
    cdef cppclass NdArray[T, NDIM, NELEM]:
        SpaceIndexer[NDIM] indexer
        T* data
        T* baseData
        size_t nElems()
        size_t nDims()

cdef extern from "ArrayHelper.h":
    cdef cppclass ArrayHelper[ArrayType]:
        ArrayHelper(ArrayType& impl_)
        void GetBuffer(Py_buffer* view, int flags)
        void ReleaseBuffer(Py_buffer* view)
