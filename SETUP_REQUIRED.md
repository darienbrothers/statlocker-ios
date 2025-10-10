# Setup Information - Profile Pictures

## ✅ No Setup Required!

**Good news:** Profile pictures are now stored as base64 data directly in Firestore, which means:
- ✅ No Firebase Storage needed
- ✅ Completely free (stays within Firestore free tier)
- ✅ Works immediately without any additional configuration
- ✅ No upgrade required

## How It Works

Profile pictures are:

1. **Resized** to 400x400 pixels (maintains aspect ratio)
2. **Compressed** to JPEG at 30% quality (~50-200KB)
3. **Converted** to base64 string
4. **Stored** in `AthleteProfile.profilePictureData` field in Firestore
5. **Decoded** and displayed when needed in `ProfileImageView`

## Technical Details

The onboarding flow includes an optional profile picture step (Step 0) that:
- Allows users to select a photo from their library
- Allows users to take a photo with the camera  
- Automatically resizes and compresses the image
- Stores directly in Firestore (no separate storage service)
- Displays the profile picture on the Dashboard hero card

## Why Base64 Instead of Firebase Storage?

- **Cost**: Completely free, no Storage service costs
- **Simplicity**: No additional Firebase configuration needed
- **Size**: Profile pictures compress to 50-200KB, well within Firestore's 1MB field limit
- **Performance**: Loads instantly from Firestore (no separate network call)
- **No Upgrade**: Works on Firebase's free Spark plan

## Image Size Limits

- Maximum original image: Any size (will be resized)
- Resized to: 400x400 pixels max dimension
- Compressed to: ~50-200KB depending on image content
- Firestore limit: 1MB per field (we stay well under this)

## Troubleshooting

### "Image too large" Warning
If you see this in console, the app automatically:
1. Resizes the image smaller (400x400)
2. Compresses more aggressively (20% quality)
3. If still too large, skips the image (onboarding continues without it)

This should never happen with the current settings, but the app handles it gracefully.

### Profile Picture Not Showing
- Check console logs for image processing messages
- Verify the image was successfully saved to Firestore
- Profile picture is optional - initials show as fallback

## Future Migration (Optional)

When you're ready to scale or optimize further:
- Firebase Storage can be enabled later for better performance at scale
- Existing profiles with base64 images will continue to work
- Migration path: Update `ProfileImageView` to handle both base64 and URLs

For now, the base64 approach is perfect for launch and completely free! 🎉
