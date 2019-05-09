using UnityEngine;

public class SpawnProjectile : MonoBehaviour
{
	public GameObject projectilePrefab;
	public Transform attackSource;


	//Called by event on the attack animation for ranged characters
	public void Fire()
	{
		if (projectilePrefab)
			Instantiate(projectilePrefab, attackSource.position, transform.rotation);
	}
}
