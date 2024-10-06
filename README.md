# Spelunk into the WaveCave!

Drop your bops at the [live site!](https://wavecave-2rxw.onrender.com)

## Introduction

WaveCave is a clone of the popular music-sharing app SoundCloud. WaveCave, as SoundCloud does, seeks to connect musical artists with the world, allowing them to share their creative ideas and endeavors amongst like-minded musicians and producers. A WaveCave user can upload their music and playback theirs and others' tracks, as well as delete and update their own. As a musician myself, it was intriguing to me to learn what goes into building such a platform and making it state-of-the-art and user-friendly. 

The technologies applied in this project include:
 - Languages: Ruby, JavaScript, JSX, HTML, and CSS
 - Backend: Ruby on Rails (API)
 - Frontend: React-Redux
 - Database: PostgreSQL
 - Hosting: Render
 - Asset Hosting: AWS Simple Cloud Storage (S3)

# MVPs

## Tracks

A WaveCave user is able to create a new track by uploading their audio file, giving their tracks a title, genre, and optionally a description and an image file.

![Upload Demo](https://media4.giphy.com/media/v1.Y2lkPTc5MGI3NjExdjVtd2E2YjV2Mmh4NW9zM3pxdm56MXZrY3Fudnl6ODJ6aTh4ZjR4bCZlcD12MV9pbnRlcm5hbF9naWZfYnlfaWQmY3Q9Zw/jHIXuM42tcl7hDizCJ/giphy.gif)

A WaveCave user can also delete a track if it's not up to their standards.

## Audio Component

Below is the logic for the actual audio component, it reads information about the current state of the audio player from the React-Redux store and changes the source of, plays, and pauses the current audio element accordingly.

```js
export default function AudioItem({ audioRef, progressBarRef, handleNext }) {
    const currentTrack = useSelector(state => {
        const { queue, isShuffled, currentIndex } = state.audio

        if(isShuffled) {
            return state.tracks[queue.shuffled[currentIndex]]
        }
        return state.tracks[queue.original[currentIndex]]
    })
    const isPlaying = useSelector(state => state.audio.isPlaying);

    useEffect(() => {
        (async () => {
        if(isPlaying && !!audioRef.current.src) {
            try {
                await audioRef.current.play();
            }
            catch(e) {
                try {
                    await audioRef.current.load();

                    audioRef.current.oncanplaythrough = async (e) => {
                        e.preventDefault();
            
                        await audioRef.current.play();
                    }
                }
                catch(e) {
                    
                }
            }

        }
        if(!isPlaying) {
            audioRef.current.oncanplaythrough = undefined;
            if (!audioRef.current.paused) {
                audioRef.current.pause();
            }
        }
        })();
    }, [isPlaying, audioRef, currentTrack])

    useEffect(() => {
        (async () => {
            if(currentTrack !== undefined && audioRef.current.src !== currentTrack?.sourceUrl) {
                audioRef.current.src = currentTrack.sourceUrl
                await audioRef.current.load();
            }
            if(currentTrack === undefined){
                audioRef.current.src = ''
            }
        })()
    }, [isPlaying, currentTrack])

    return 
		<audio
			className={`audio-track ${currentTrack?.title || ''}`}
			ref={audioRef}
			onEnded={handleNext} />
    
}
```

## Audio Playback Progress Bar

Below is the logic for the ProgressBar component to update itself as the audio playback progresses

```js
export default function ProgressBar({ progressBarRef, audioRef }) {
    const isPlaying = useSelector(state => state.audio.isPlaying)
    const playAnimationRef = useRef();

    const [time, setTime] = useState(0);

    const handleProgressChange = (e) => {
        e.stopPropagation()
        const newValue = progressBarRef.current ? progressBarRef.current.value : 0
        audioRef.current.currentTime = (progressBarRef.current.value / 100) * audioRef.current.duration;
        progressBarRef.current.style.setProperty(
            '--range-progress',
            `${newValue}%`
        );
    };

    const updateProgress = useCallback(() => {
        const newValue = audioRef.current ? (audioRef.current.currentTime / audioRef.current.duration) * 100 : 0
        setTime(audioRef.current?.currentTime || 0);
        progressBarRef.current.value = newValue;
        progressBarRef.current.style.setProperty(
            '--range-progress',
            `${newValue}%`
        );
        playAnimationRef.current = requestAnimationFrame(updateProgress);
    }, [audioRef, progressBarRef.current?.value, handleProgressChange]);
    
    useEffect(() => {
        if (isPlaying) {
          playAnimationRef.current = requestAnimationFrame(updateProgress);
        } 
        if (!isPlaying) {
          cancelAnimationFrame(playAnimationRef.current);
        }
    }, [isPlaying, audioRef, updateProgress]);
// ...
```

# Coming Soon

## Comments

A WaveCave user will be able to comment on audio tracks, having each comment saved to the database with a timestamp that corresponds to the audio playback time at the time of initiating the comment. Other users will see these comments as they appear in the playback timeline if they are on the view page of the track that's currently playing in the audio player. Users will also be able to simply mouse over these comments to reveal them whether or not the track is currently being played.


## Sets (Playlists, Albums, EPs, etc...)

A WaveCave user will be able to curate playlists of their favorite tracks. Owners of tracks will be able to bundle their own tracks as albums or collections, which will have special features such as scheduled release, and other users will be able to follow these playlists and play them back in the audio player.

## Follows

A WaveCave user will be able to follow playlists as well as other users to stay subscribed to all their new releases

## Likes

A WaveCave user will be able to like tracks and comments, which may affect another feature also soon to come...

# Thanks

This project was made in the span of 14-days. Thanks for making a splash with me at WaveCave!

