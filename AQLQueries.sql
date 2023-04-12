/* AQL query to find out the average duration for which a rider rents a bike */

RETURN AVG(
  FOR trip IN trips
    RETURN trip.tripduration
)

/* AQL query for to find out the most frequently accessed station */

FOR trip IN trips
  COLLECT station = trip.`start station name` WITH COUNT INTO count
  SORT count DESC
  LIMIT 1
  RETURN station

/* AQL query for to find out the rush hours */


FOR trip IN trips
  LET startHour = DATE_HOUR(DATE_TIMESTAMP(trip.starttime))
  FILTER startHour >= 7 AND startHour <= 9 OR startHour >= 16 AND startHour <= 18
  COLLECT hour = startHour WITH COUNT INTO count
  SORT count DESC
  RETURN {hour: hour, count: count}


/* AQL query for Bike usage by user type */

FOR trip IN trips
    COLLECT userType = trip.usertype WITH COUNT INTO count
    RETURN { userType: userType, tripCount: count }
