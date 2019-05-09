using UnityEngine;

public class DestroyObject : MonoBehaviour
{
	public float timeToLive = 2f;

    void Start()
    {
        Destroy(gameObject, timeToLive);
    }  
}
