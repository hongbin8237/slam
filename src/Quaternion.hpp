#ifndef  quaternion_INC
#define  Quaternion_INC

/*
 * =====================================================================================
 *        Class:  Quaternion
 *  Description:  Class for storing and transforming quaternion.
 * =====================================================================================
 */
class Quaternion
{
    public:
        /* ====================  LIFECYCLE     ======================================= */
        Quaternion ( cv::Vec3d q )
        {
            coord = q;
        }/* constructor */

        /* ====================  ACCESSORS     ======================================= */

        /* ====================  MUTATORS      ======================================= */

        /* ====================  OPERATORS     ======================================= */
        cv::Vec3d euler();
        cv::Vec3d rotation();

        /* ====================  DATA MEMBERS  ======================================= */
        cv::Vec4d coord;
    protected:
        /* ====================  METHODS       ======================================= */

        /* ====================  DATA MEMBERS  ======================================= */

    private:
        /* ====================  METHODS       ======================================= */

        /* ====================  DATA MEMBERS  ======================================= */

}; /* -----  end of class Quaternion  ----- */

#endif   /* ----- #ifndef Quaternion_INC  ----- */
