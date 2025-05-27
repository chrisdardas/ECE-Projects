'use strict';

/**
 * Retrieve a list of reviews
 *
 * restaurantName String The name of the restaurant to filter reviews (optional)
 * returns List
 **/
exports.reviewsGET = function (restaurantName) {
  return new Promise(function (resolve, _) {
    // Mock reviews data
    const mockReviews = [
      {
        id: '1',
        user_id: 'user_1',
        restaurant_id: 'mamalouka',
        rating: 4.5,
        comment: 'Great food and service!',
      },
      {
        id: '2',
        user_id: 'user_2',
        restaurant_id: 'mamalouka',
        rating: 4.0,
        comment: 'Nice ambiance, would visit again.',
      },
      {
        id: '3',
        user_id: 'user_3',
        restaurant_id: 'another-restaurant',
        rating: 3.0,
        comment: 'Average experience.',
      },
    ];

    // Filter reviews based on the restaurantName
    let filteredReviews = mockReviews;
    if (restaurantName) {
      filteredReviews = mockReviews.filter(
        (review) => review.restaurant_id === restaurantName
      );
    }

    // Resolve the filtered reviews
    resolve(filteredReviews);
  });
};
