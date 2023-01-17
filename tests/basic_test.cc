#include <gtest/gtest.h>

#include <vector>

using namespace std;

TEST(TestSuiteName, TestName) { return; }

TEST(TestBasic, Assert) {
  vector<int> x{1, 2, 3, 4};
  vector<int> y{1, 2, 3, 4};

  ASSERT_EQ(x.size(), y.size()) << "Vectors x and y are of unequal length";

  for (auto i = 0LU; i < x.size(); ++i) {
    EXPECT_EQ(x[i], y[i]) << "Vectors x and y differ at index " << i;
  }
}

#include <boost/math/special_functions/factorials.hpp>
TEST(TestBasic, TestFactorial) {
  using boost::math::factorial;
  EXPECT_EQ(factorial<double>(0), 1);
  EXPECT_EQ(factorial<double>(1), 1);
  EXPECT_EQ(factorial<double>(2), 2);
  EXPECT_EQ(factorial<double>(3), 6);
  EXPECT_EQ(factorial<double>(8), 40320);
}
