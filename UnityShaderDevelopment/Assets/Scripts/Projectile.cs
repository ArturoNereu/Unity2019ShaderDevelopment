using UnityEngine;

public class Projectile : MonoBehaviour
{
	public float moveSpeed;
	public GameObject impactPrefab;
	public Transform target;


	void Start()
	{
		if (target != null)
			transform.LookAt(target.position);
	}

	void Update()
	{
		transform.Translate(0f, 0f, moveSpeed * Time.deltaTime);
	}

	void OnTriggerEnter(Collider other)
	{
		if (impactPrefab)
			Instantiate(impactPrefab, transform.position, Quaternion.identity);

		Destroy(gameObject);
	}
}

