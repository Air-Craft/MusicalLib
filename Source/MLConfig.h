/** ********************************************************************************************************************/
#pragma mark -
#pragma mark Debug

#if MUSICAL_LIB_DEBUG > 0
#	define MLLOG(fmt, ...) NSLog((@"%s [L%d] " fmt), __PRETTY_FUNCTION__, __LINE__, ##__VA_ARGS__); 
#else
#	define MLLOG(...)
#endif