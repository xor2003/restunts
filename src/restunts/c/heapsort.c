/* stolen from bsort.c, written by
 *   Robert Fowler,  Computer Science Department, U of Rochester
 *   February, 1989.
 *
 *   Parts are inherited from
 *   a test application for PLATINUM that runs a variation of
 *   a Batcher Odd-Even Merge sort on a random array of integers.
 *
 *   This code is adapted for PLATINUM from  program written by
 *   John Mellor-Crummey to exercise the PUTTs Toolkit at the U of R.
 *   This in turn was derived from code by Takahide Ohkami.
 */

 /*
oct 11 2014: adapted for restunts from here:
    http://wotug.org/parallel/parlib/p4/msort/heapsort.c

changes:
	- sorts by descending order
	- sorts a data array based on the heap array contents
 */

static void heapify(int* heap, int* data, int start, int end) {
	int last = ((end + 1) >> 1);
	while (start < last) {
		int lson = (start << 1) + 1;
		int rson = lson + 1;
		int smallest;

		if (rson <= end) {
			if (heap[lson] >= heap[rson]) {
				smallest = rson;
			} else {
				smallest = lson;
			}
		} else {
			smallest = lson;
		}

		if (heap[smallest] <= heap[start]) {
			int temp = heap[start];
			heap[start] = heap[smallest];
			heap[smallest] = temp;

			temp = data[start];
			data[start] = data[smallest];
			data[smallest] = temp;
			start = smallest;
		} 
		else break;
	}
}

void heapsort_by_order(int n, int* heap, int* data) {
	int i;
	for(i = (n - 1) / 2; i >= 0; i--) {
		heapify(heap, data, i, n - 1);
	}

	for(i = n - 1; i > 0; i--) {
		int temp = heap[0];
		heap[0] = heap[i];
		heap[i] = temp;

		temp = data[0];
		data[0] = data[i];
		data[i] = temp;
		heapify(heap, data, 0, i - 1);
	}
}
