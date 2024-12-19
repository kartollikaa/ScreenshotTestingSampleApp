package ru.kartollika.screenshot.testing

import androidx.activity.ComponentActivity
import androidx.compose.material3.MaterialTheme
import androidx.compose.ui.test.junit4.createAndroidComposeRule
import org.junit.Rule
import org.junit.Test
import org.junit.runner.RunWith
import org.robolectric.RobolectricTestRunner
import org.robolectric.annotation.GraphicsMode
import ru.kartollika.screenshot.testing.common.recordScreenshot
import ru.kartollika.screenshot.testing.ui.components.Header

@RunWith(RobolectricTestRunner::class)
@GraphicsMode(GraphicsMode.Mode.NATIVE)
class TextScreenshotTests {

  @get:Rule
  val composeTestRule = createAndroidComposeRule<ComponentActivity>()

  @Test
  fun text() {
    composeTestRule.recordScreenshot {
      MaterialTheme {
        Header(
          text = "Text sample"
        )
      }
    }
  }
}